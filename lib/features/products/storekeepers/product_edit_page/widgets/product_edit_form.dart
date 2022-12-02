import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker_big.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_categories_page/widgets/product_categories_picker.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_edit_page/widgets/exit_dialog.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_edit_page/widgets/product_allergens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

class ProductEditForm extends StatefulWidget {
  const ProductEditForm({
    Key? key, 
    required this.product
  }) : super(key: key);

  final Product? product;

  @override
  State<ProductEditForm> createState() => _ProductEditFormState();
}

class _ProductEditFormState extends State<ProductEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  List<String> _productCategories = [];
  List<String> _productTags = [];
  List<String> _productAllergens = [];

  String _currentUnit = 'Unitée';
  double _currentTVA = 20;
  bool _isBreton = false;
  bool _hasGluten = true;
  ClFile? _currentImage;

  MutationOptions<dynamic> _createProductMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutCreateProduct),
      onError: (error) async {
        final bool shouldStay = await showDialog<bool?>(
          context: context, 
          builder: (context) => const ExitDialog()) ?? true;

          if (!shouldStay) Navigator.of(context).pop();
      },
      onCompleted: (dynamic data) {
        if (data != null) {
          Navigator.of(context).pop(true);
        }
      }
    );
  }

  MutationOptions<dynamic> _updateProductMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateProduct),
      onError: (error) async {
        final bool shouldStay = await showDialog<bool?>(
          context: context, 
          builder: (context) => const ExitDialog()) ?? true;

          if (!shouldStay) Navigator.of(context).pop();
      },
      onCompleted: (dynamic data) {
        if (data != null) {
          Navigator.of(context).pop(true);
        }
      }
    );
  }

  void _initialize() {
    if (widget.product != null) {
      _nameTextController.text = widget.product!.name;
      _priceTextController.text = widget.product!.price.toString();
      _descriptionTextController.text = widget.product!.description ?? "";

      _currentTVA = widget.product!.tva ?? 20;
      _currentUnit = widget.product!.unit ?? "Unitée";

      _productTags = widget.product!.tags.toList();
      _productAllergens = widget.product!.allergens.toList();
      _productCategories = widget.product!.categories.toList();
      
      _isBreton = widget.product!.isBreton ?? false;
      _hasGluten = widget.product!.hasGluten ?? true;
    }
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant ProductEditForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _createProductMutationOptions(),
      builder: (runCreateMutation, createMutationResult) {
        if (createMutationResult?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return Mutation<dynamic>(
          options: _updateProductMutationOptions(),
          builder: (runUpdateMutation, updateMutationResult) {
            if (updateMutationResult?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return _buildContent(
              hasException: (createMutationResult?.hasException ?? false)
                || (updateMutationResult?.hasException ?? false),
              runCreateMutation: runCreateMutation,
              runUpdateMutation: runUpdateMutation,
            );
          }
        );
      },
    );
  }

  Widget _buildContent({
    bool hasException = false,
    required RunMutation runCreateMutation,
    required RunMutation runUpdateMutation,
  }) {
    return WillPopScope(
      onWillPop: () async {
        _onSave(runCreateMutation: runCreateMutation, runUpdateMutation: runUpdateMutation);
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenHelper.instance.horizontalPadding,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;
            
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (hasException) ...{
                            const ClStatusMessage(
                              message: "Le produit n'a pas pu être envoyé...",
                            ),
                            const SizedBox(height: 20,)
                          },
            
                          // Le container principale
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // L'image
                                Flexible(
                                  flex: isBig ? 3 : 44 ,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 560),
                                    child: AspectRatio(
                                      aspectRatio: 0.65,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: ClImagePickerBig(
                                          imageURL: "$kImagesBaseUrl/products/${widget.product?.id ?? ""}.jpg",
                                          onImageSelected: (image) {
                                            setState(() {
                                              _currentImage = image;
                                            });
                                          },
                                          imageData: _currentImage,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12,),
            
                                // La ligne d'informations basiques
                                Expanded(
                                  flex: isBig ? 6 : 56,
                                  child: Builder(
                                    builder: (context) {
                                      final List<Widget> children = [
                                        // Le nom du produit
                                        Flexible(
                                          child: ClTextInput(
                                            controller: _nameTextController, 
                                            labelText: "Nom du produit",
                                            maxLenght: 18,
                                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                            validator: (value) {
                                              if (value.isEmpty) return "Vous devez rentrer un nom";
                                              if (value.length >= 18) return "La taille du nom ne doit pas dépasser 18 caratères";
                                              return null;
                                            }, 
                                          ),
                                        ),
                                        const SizedBox(height: 6, width: 20,),
            
                                        // La TVA
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 150),
                                          child: ClDropdown<double>(
                                            items: {
                                              0: "0%",
                                              5.5: "5,5%",
                                              10: "10%",
                                              20: "20%",
                                            },
                                            currentValue: _currentTVA,
                                            label: "% de TVA",
                                            onChanged: (value) {
                                              setState(() {
                                                _currentTVA = value ?? 20;
                                              });
                                            },
                                            validator: null,
                                          ),
                                        ),
                                        const SizedBox(height: 6, width: 20,),
            
                                        // Le prix et son unité
                                        Flexible(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Prix
                                              Flexible(
                                                flex: 2,
                                                child: ClTextInput(
                                                  controller: _priceTextController,
                                                  inputType: const TextInputType.numberWithOptions(decimal: true),
                                                  labelText: "Prix TTC",
                                                  hintText: "Ex : 5,00",
                                                  validator: (price) {
                                                    if (double.tryParse(price) == null) return "Vous devez rentrer un nombre valide";
                                          
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 12,),
                                          
                                              // Unitée
                                              Flexible(
                                                flex: 3,
                                                child: ClDropdown<String>(
                                                  currentValue: _currentUnit,
                                                  items: const {
                                                    "Unitée": "Unitée",
                                                    "Gramme": "Gramme",
                                                    "Pack": "Pack"
                                                  },
                                                  label: "",
                                                  validator: (value) {
                                                    if ((value ?? '').isEmpty) return "Vous devez choisir une unité.";
                                          
                                                    return null;
                                                  },
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _currentUnit = newValue ?? 'Unitée';
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ];
            
                                      if (constraints.maxWidth >= ScreenHelper.breakpointPC) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: children,
                                              ),
                                            ),
                                            const SizedBox(height: 6,),
            
                                            ..._columnAdaptivePart(isBig: true)
                                          ],
                                        );
                                      }
            
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: children,
                                      );
                                    }
                                  ),
                                )
                              ],
                            ),
                          ),
            
                          if (!isBig)
                            ..._columnAdaptivePart(),
                          const SizedBox(height: 10,),
            
                          Flexible(
                            child: ProductAllergensPicker(
                              allergens: _productAllergens,
                              onAllergenAdded: (allergen) {
                                setState(() {
                                  _productAllergens.add(allergen);
                                });
                              },
                              onAllergenRemoved: (allergen) {
                                setState(() {
                                  _productAllergens.remove(allergen);
                                });
                              },
                            )
                          ),
                          const SizedBox(height: 10,),
            
                          Flexible(
                            child: ProductCategoriesPicker(
                              initialCategories: _productCategories,
                              onAddCategory: (category) => _productCategories.add(category),
                              onRemoveCategory: (category) => _productCategories.remove(category),
                            ),
                          )
                        ],
                      );
                    }
                  ),
                ),
              ),
            ),
          ),
    
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () => _onSave(
                  runCreateMutation: runCreateMutation,
                  runUpdateMutation: runUpdateMutation,
                ),
                child: Text(widget.product == null ? "Ajouter mon produit" : "Modifier mon produit"),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _columnAdaptivePart({bool isBig = false}) {
    return [
      // Checkbox du produit Breton
      Flexible(
        child: Wrap(
          spacing: 8, runSpacing: 8,
          children: [
            ClCheckBox(
              value: _isBreton, 
              text: "Ce produit est Breton",
              onChanged: (value) {
                setState(() {
                  _isBreton = value ?? false;
                });
              },
            ),

            ClCheckBox(
              value: !_hasGluten, 
              text: "Ce produit est sans Glutten",
              onChanged: (value) {
                setState(() {
                  _hasGluten = !(value ?? false);
                });
              }, 
            )
          ],
        ),
      ),
      const SizedBox(height: 6,),

      // La description
      Flexible(
        child: ClTextInput(
          controller: _descriptionTextController,
          labelText: "Description",
          hintText: "Description du produit",
          inputType: TextInputType.multiline,
          maxLines: isBig ? 10 : 5,
          validator: (value) {
            if (value.isEmpty) return "Vous devez rentrer une description";

            return null;
          },
        ),
      ),
      const SizedBox(height: 12,),

      // Les tags
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Tags spécifiques", style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: 6,),
            Flexible(
              child: Tags(
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.start,
                textField: TagsTextField(
                  inputDecoration: InputDecoration(
                    hintText: 'Nouveau Tag',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    fillColor: Theme.of(context).colorScheme.surface,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  autofocus: false,
                  onSubmitted: (newTag) {
                    if (_productTags.contains(newTag)) return;
            
                    setState(() {
                      _productTags.add(newTag);
                    });
                  },
                ),
                itemCount: _productTags.length,
                itemBuilder: (index) {
                  final tag = _productTags[index];
            
                  return ItemTags(
                    alignment: MainAxisAlignment.center,
                    index: index, 
                    title: tag,
                    pressEnabled: false,
                    color: Theme.of(context).colorScheme.secondary,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    textStyle: const TextStyle(fontSize: 12),
                    removeButton: ItemTagsRemoveButton(
                      onRemoved: () {
                        setState(() {
                          _productTags.removeAt(index);
                        });
            
                        return true;
                      }
                    ),
                  );
                },
              ),
            ),
          ],
        )
        // child: ProductTagsPicker(
        //   tags: _productTags,
        //   onTagAdded: (tag) {
        //     if (_productTags.contains(tag)) return;

        //     setState(() {
        //       _productTags.add(tag);
        //     });
        //   },
        //   onTagRemoved: (tag) {
        //     setState(() {
        //       _productTags.remove(tag);
        //     });
        //   },
        // ),
      ),
      const SizedBox(height: 6,),
    ];
  }

  void _onSave({
    required RunMutation runCreateMutation,
    required RunMutation runUpdateMutation,
  }) {
    if (!_formKey.currentState!.validate()) return;

    final Map<String, dynamic> values = <String, dynamic>{
      "name": _nameTextController.text,
      "description": _descriptionTextController.text,
      "price": double.parse(_priceTextController.text),
      "unit": _currentUnit,
      "tva": _currentTVA,
      "isBreton": _isBreton,
      "hasGluten": _hasGluten,
      "tags": _productTags,
      "allergens": _productAllergens,
      "categories": _productCategories,
      if (_currentImage != null) 
        "image": MultipartFile.fromBytes(
          "image",
          base64Decode(_currentImage!.base64content!),
          filename: _currentImage!.filename
        ),
    };

    if (widget.product != null) {
      runUpdateMutation(<String, dynamic>{
        "id": widget.product!.id,
        "changes": values 
      });
    }
    else {
      runCreateMutation(<String, dynamic>{
        "input": values
      });
    }

    imageCache.clear();
  }
}