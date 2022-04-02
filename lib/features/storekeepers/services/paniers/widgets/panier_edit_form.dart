import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dateime_picker.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker_big.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/services_products_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

class PanierEditForm extends StatefulWidget {
  const PanierEditForm({
    Key? key,
    required this.panier,
    required this.runMutation,
  }) : super(key: key);

  final Panier? panier;
  final RunMutation? runMutation;

  @override
  State<PanierEditForm> createState() => PanierEditFormState();
}

class PanierEditFormState extends State<PanierEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _quantityTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();

  final List<String> _selectedProductsIDs = [];
  final Map<String, int> _quantities = {};

  String _category = PanierCategory.permanent;
  DateTime? _endingDate;
  ClFile? _image;

  void _initialize() {
    if (widget.panier != null) {
      _nameTextController.text = widget.panier!.name;
      _descriptionTextController.text = widget.panier!.description;
      _quantityTextController.text = widget.panier!.quantity.toString();
      _priceTextController.text = widget.panier!.price.toString();

      if (_selectedProductsIDs.isNotEmpty) {
        _selectedProductsIDs.removeRange(0, _selectedProductsIDs.length - 1);
      }

      for (final product in widget.panier!.products) {
        _quantities[product.product.id!] = product.quantity;
        _selectedProductsIDs.add(product.product.id!);
      }

      _endingDate = widget.panier!.endingDate;
      _category = widget.panier!.category;
    }
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant PanierEditForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: ScreenHelper.horizontalPadding,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // First section with image picker
                Flexible(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;
            
                      if (isBig) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // The image picker
                            Expanded(
                              flex: 38,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 500),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: ClImagePickerBig(
                                    imageURL: "$kImagesBaseUrl/paniers/${widget.panier?.id ?? ""}.jpg",
                                    onImageSelected: (file) {
                                      setState(() {
                                        _image = file;
                                      });
                                    },
                                    imageData: _image,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12,),
            
                            // The content
                            Expanded(flex: 62, child: _buildFirstSection())
                          ],
                        );
                      }
            
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // The image picker
                          Flexible(
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ClImagePickerBig(
                                imageURL: "$kImagesBaseUrl/paniers/${widget.panier?.id ?? ""}.jpg",
                                onImageSelected: (file) {
                                  setState(() {
                                    _image = file;
                                  });
                                },
                                imageData: _image,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12,),
            
                          Flexible(child: _buildFirstSection())
                        ],
                      );
                    },
                  ),
                ),
          
                // The products picker
                Flexible(
                  child: ServicesProductsPicker(
                    initialProductsIDs: _selectedProductsIDs,
                    onProductTapped: _onProuctSelected,
                    initialQuantities: _quantities,
                    onQuantityChanged: _onQuantityUpdated,
                  ),
                )         
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le champs du nom
        Flexible(
          child: ClTextInput(
            controller: _nameTextController,
            labelText: "Nom du panier",
            hintText: "Quelques bières",
            validator: (value) {
              if (value.isEmpty) return "Vous devez choisir un nom";
              return null;
            },
          ),
        ),
        const SizedBox(height: 12,),

        // Le champs de description
        Flexible(
          child: ClTextInput(
            controller: _descriptionTextController,
            labelText: "Description du panier",
            hintText: "Panier contenant des bières bretonne",
            inputType: TextInputType.multiline,
            maxLines: 3,
            validator: (value) {
              if (value.isEmpty) return "vous devez rentrer une description";
              return null;
            },
          ),
        ),
        const SizedBox(height: 12,),

        // Quantité et prix
        Flexible(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisExtent: 90,
              mainAxisSpacing: 16,
            ),
            children: [
              // Quantité
              ClTextInput(
                controller: _quantityTextController,
                labelText: "Quantité",
                hintText: "10",
                inputType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer une cantité";

                  final int? quantity = int.tryParse(value);
                  if (quantity == null) return "Le nombre n'est pas valide";
                  if (quantity < 1) return "Vous devez avoir au moins 1 panier";
                  return null;
                },
              ),

              // Le prix
              ClTextInput(
                controller: _priceTextController,
                labelText: "Prix du panier",
                hintText: "5,00€",
                inputType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer un prix";

                  final double? price = double.tryParse(value);
                  if (price == null) return "Le nombre n'est pas valide";
                  if (price < 0.01) return "Vous ne pouvez pas avoir un prix aussi faible";
                  return null;
                },
              )
            ],
          ),
        ),

        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth >= 400 ? 2 : 1,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 90,
                  mainAxisSpacing: 16,
                ),
                children: [
                  // Catégorie
                  ClDropdown<String>(
                    currentValue: _category,
                    items: PanierCategory.detailled,
                    label: "Catégorie du panier",
                    onChanged: (value) {
                      setState(() {
                        _category = value ?? PanierCategory.permanent;
                      });
                    },
                    validator: null,
                  ),

                  if (_category == PanierCategory.temporary)
                    ClDateTimePicker(
                      type: DateTimePickerType.dateTime,
                      initialDate: _endingDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      label: "Date de fin du panier",
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _endingDate = DateTime.tryParse(value);
                        });
                      },
                      validator: (value) {
                        if (_category != PanierCategory.temporary) return null; 
                        if (value?.isEmpty ?? true) return "Vous devez choisir une date";
                        if (DateTime.parse(value!).isBefore(DateTime.now())) return "La date doit être supérieur à maintenant";

                        return null;
                      },
                    )
                ],
              );
            }
          ),
        )
      ],
    );
  }

  void _onProuctSelected(String productID) {
    setState(() {
      if (_selectedProductsIDs.contains(productID)) {
        _selectedProductsIDs.remove(productID);
      } 
      else {
        _selectedProductsIDs.add(productID);
      }
    });
  } 

  void _onQuantityUpdated(String productID, int newQuantity) {
    setState(() {
      _quantities[productID] = newQuantity;
    });
  }
  void save() {
    if (!_formKey.currentState!.validate()) return;

    if (widget.runMutation != null) {
      widget.runMutation!(<String, dynamic>{
        "id": widget.panier?.id,
        "name": _nameTextController.text,
        "description": _descriptionTextController.text,
        "category": _category,
        "quantity": int.parse(_quantityTextController.text),
        "price": double.parse(_priceTextController.text),
        if (_image != null) 
          "image": MultipartFile.fromBytes(
            "image",
            base64Decode(_image!.base64content!),
            filename: _image!.filename
          ),
        "endingDate": _endingDate?.toUtc().toIso8601String(),
        "products": [
          for (final id in _selectedProductsIDs) {
            "quantity": _quantities[id],
            "productID": id
          }
        ]
      });
    }
  }
}