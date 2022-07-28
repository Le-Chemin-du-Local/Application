import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/badge.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dateime_picker.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker_big.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
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
    required this.type,
  }) : super(key: key);

  final Panier? panier;
  final RunMutation? runMutation;

  final String type;

  @override
  State<PanierEditForm> createState() => PanierEditFormState();
}

class PanierEditFormState extends State<PanierEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  final TextEditingController _quantityTextController = TextEditingController();

  final List<String> _selectedProductsIDs = [];
  final Map<String, int> _quantities = {};

  double _price = 0.0;
  double _reductionPercentage = 0.0;
  DateTime? _endingDate;
  ClFile? _image;

  void _initialize() {
    if (widget.panier != null) {
      _nameTextController.text = widget.panier!.name;
      _descriptionTextController.text = widget.panier!.description;
      _quantityTextController.text = widget.panier!.quantity.toString();

      if (_selectedProductsIDs.isNotEmpty) {
        _selectedProductsIDs.removeRange(0, _selectedProductsIDs.length - 1);
      }

      for (final product in widget.panier!.products) {
        _quantities[product.product.id!] = product.quantity;
        _selectedProductsIDs.add(product.product.id!);
      }

      _price = widget.panier!.price;
      _endingDate = widget.panier!.endingDate;
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
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: ScreenHelper.instance.horizontalPadding,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Les infos sur le prix
                Flexible(child: _buildInfos()),
                const SizedBox(height: 20,),

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
                    onProductTapped: (product) => _onProuctSelected(product.id!, product.price ?? 0.0),
                    initialQuantities: _quantities,
                    onQuantityChanged: (product, quantity) => _onQuantityUpdated(product.id!, product.price ?? 0.0, quantity),
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

              // La date si besoin
              if (widget.type == PanierType.temporary)
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
                    if (widget.type != PanierType.temporary) return null; 
                    if (value?.isEmpty ?? true) return "Vous devez choisir une date";
                    if (DateTime.parse(value!).isBefore(DateTime.now())) return "La date doit être supérieur à maintenant";

                    return null;
                  },
                ),

              ClDropdown<double>(
                label: "% de réduction",
                items: {
                  0.0: "0%",
                  5.0: "5%",
                  10: "10%",
                }, 
                currentValue: _reductionPercentage, 
                onChanged: (value) {
                  setState(() {
                    _reductionPercentage = value ?? 0.0;
                  });
                }, 
                validator: null
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfos() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding, vertical: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;

          final List<Widget> children = [
            Text("Produits du panier", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w500
            )),
            if (!isBig) 
              const SizedBox(height: 30,),

            Flexible(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                // crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildInfoSection("Votre panier contient", "${_selectedProductsIDs.length} produit(s)"),
                  _buildInfoSection("Prix total", "$_price€"),
                  _buildInfoSection("Prix avec rabais", "${_price * ((100-_reductionPercentage) / 100)}€")
                ],
              ),
            ),
          ];

          if (isBig) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }
      ),
    );
  }

  Widget _buildInfoSection(String title, String badgeText) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(title, style: Theme.of(context).textTheme.headlineSmall,)),
        const SizedBox(width: 20,),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badgeText,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondary
              ),
            ),
          ),
        )
      ],
    );
  }

  void _onProuctSelected(String productID, double price) {
    int quantity = _quantities[productID] ?? 1;
    setState(() {
      if (_selectedProductsIDs.contains(productID)) {
        _selectedProductsIDs.remove(productID);
        _quantities[productID] = 0;
        _price -= price * quantity;
      } 
      else {
        _selectedProductsIDs.add(productID);
        _quantities[productID] = 1;
        _price += price;
      }
    });
  } 

  void _onQuantityUpdated(String productID, double price, int newQuantity) {
    int oldQuantity = _quantities[productID] ?? 1;
    setState(() {
      _price -= price * oldQuantity;
      _price += price * newQuantity;
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
        "type": widget.type,
        "quantity": int.parse(_quantityTextController.text),
        "price": _price * ((100-_reductionPercentage) / 100),
        "reduction": _reductionPercentage,
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