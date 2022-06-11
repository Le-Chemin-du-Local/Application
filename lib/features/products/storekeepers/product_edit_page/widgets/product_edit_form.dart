import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker_big.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_categories_page/widgets/product_categories_picker.dart';
import 'package:flutter/material.dart';
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

  String _currentUnit = '';
  double _currentTVA = 20;
  bool _isBreton = false;
  ClFile? _currentImage;

  MutationOptions<dynamic> _createProductMutationOptions(BuildContext context) {
    return MutationOptions<dynamic>(
      document: gql(mutCreateProduct),
      onCompleted: (dynamic data) {
        if (data != null) {
          Navigator.of(context).pop(true);
        }
      }
    );
  }

  MutationOptions<dynamic> _updateProductMutationOptions(BuildContext context) {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateProduct),
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
      _productCategories = widget.product!.categories;
      
      _isBreton = widget.product!.isBreton ?? false;
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
      options: _createProductMutationOptions(context),
      builder: (runCreateMutation, createMutationResult) {
        if (createMutationResult?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        return Mutation<dynamic>(
          options: _updateProductMutationOptions(context),
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
    // We generate the content first beceause it's the 
    // same whatever is the screen size
    final List<Widget> content = [
      Flexible(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The error message if needed
              if (hasException) ...{
                const ClStatusMessage(
                  message: "Les modifications n'ont pas pu être sauvegardées...",
                ),
                const SizedBox(height: 20,),
              },

              // The detail row (with image, name, price, ...)
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool useBigLayout = constraints.maxWidth > ScreenHelper.breakpointPC;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (useBigLayout) 
                        Flexible(child: _buildBigLayout())
                      else 
                        Flexible(child: _buildSmallLayout())
                        
                    ],
                  );
                } 
              ),
              const SizedBox(height: 12,),

              Flexible(
                child: ProductCategoriesPicker(
                  initialCategories: _productCategories,
                  onAddCategory: (category) => _productCategories.add(category),
                  onRemoveCategory: (category) => _productCategories.remove(category),
                ),
              )
            ],
          ),
        ),
      )
    ];

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: ScreenHelper.maxContainerWidth),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > ScreenHelper.breakpointPC) {
                      return Row(
                        children: content,
                      );
                    }
                
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: content,
                    );
                  },
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
    );
  }

  Widget _buildBigLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // L'image
        Flexible(
          flex: 25,
          child: _buildImagePicker()
        ),
        const SizedBox(width: 12,),

        Expanded(
          flex: 75,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(child: _buildBasicInfoRow()),
              const SizedBox(height: 20,),

              Flexible(
                child: ClTextInput(
                  controller: _descriptionTextController,
                  labelText: "Description",
                  hintText: "Description du produit",
                  inputType: TextInputType.multiline,
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez rentrer une description";
        
                    return null;
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSmallLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(child: _buildImagePicker()),
        const SizedBox(height: 20,),

        Flexible(child: _buildBasicInfoRow()),
        const SizedBox(height: 20,),

        Flexible(
          child: ClTextInput(
            controller: _descriptionTextController,
            labelText: "Description",
            hintText: "Description du produit",
            inputType: TextInputType.multiline,
            maxLines: 5,
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer une description";
  
              return null;
            },
          ),
        )
      ],
    );
  }

  Widget _buildBasicInfoRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int crossAxisCount = constraints.maxWidth >= ScreenHelper.breakpointTablet ? 2 : 1;

        return GridView(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisExtent: 170
          ),
          primary: true,
          shrinkWrap: true,
          children: [
            // Premiere section
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Nom du produit
                Flexible(
                  child: ClTextInput(
                    controller: _nameTextController,
                    labelText: "Nom du produit",
                    hintText: "Nom de votre produit",
                    validator: (value) {
                      if (value.isEmpty) return "Vous devez renseigner un nom";
                
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16,),

                // La Checkbox produit breton
                Flexible(
                  child: ClCheckBox(
                    value: _isBreton, 
                    text: "Ce produit est Breton",
                    onChanged: (value) {
                      setState(() {
                        _isBreton = value ?? false;
                      });
                    },
                  ),
                )
              ],
            ),

            // Second section
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Le prix
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // La TVA
                      Flexible(
                        flex: 3,
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
                      const SizedBox(width: 12,),

                      // Prix
                      Flexible(
                        flex: 3,
                        child: ClTextInput(
                          controller: _priceTextController,
                          inputType: const TextInputType.numberWithOptions(decimal: true),
                          labelText: "Prix",
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
                        flex: 4,
                        child: ClDropdown<String>(
                          currentValue: _currentUnit,
                          items: const {
                            "": "unitée",
                            "unit": "Unité",
                            "gramme": "Gramme"
                          },
                          validator: (value) {
                            if ((value ?? '').isEmpty) return "Vous devez choisir une unité.";

                            return null;
                          },
                          onChanged: (newValue) {
                            setState(() {
                              _currentUnit = newValue ?? '';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),

                // TODO: les tags
                
              ],
            )
          ],
        );
      }
    );
  }

  Widget _buildImagePicker() {
    return ClCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
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
    );
  }

  void _onSave({
    required RunMutation runCreateMutation,
    required RunMutation runUpdateMutation,
  }) {
    if (!_formKey.currentState!.validate()) return;

    if (widget.product != null) {
      runUpdateMutation(<String, dynamic>{
        "id": widget.product!.id,
        "name": _nameTextController.text,
        "description": _descriptionTextController.text,
        "price": double.parse(_priceTextController.text),
        "unit": _currentUnit,
        "tva": _currentTVA,
        "isBreton": _isBreton,
        "categories": _productCategories,
        if (_currentImage != null) 
          "image": MultipartFile.fromBytes(
            "image",
            base64Decode(_currentImage!.base64content!),
            filename: _currentImage!.filename
          ),
      });
    }
    else {
      runCreateMutation(<String, dynamic>{
        "name": _nameTextController.text,
        "description": _descriptionTextController.text,
        "price": double.parse(_priceTextController.text),
        "unit": _currentUnit,
        "tva": _currentTVA,
        "isBreton": _isBreton,
        "categories": _productCategories,
        if (_currentImage != null) 
          "image": MultipartFile.fromBytes(
            "image",
            base64Decode(_currentImage!.base64content!),
            filename: _currentImage!.filename
          ),
      });
    }

    imageCache.clear();
  }
}