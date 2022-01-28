import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/widgets/product_categories_picker.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
    this.product
  }) : super(key: key);

  final Product? product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();

  final List<String> _productCategories = [];

  String _currentUnit = '';
  bool _isBreton = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      _nameTextController.text = widget.product!.name;
      _priceTextController.text = widget.product!.price.toString();
      _descriptionTextController.text = widget.product!.description;

      _productCategories.addAll(widget.product!.categories);
      
      _isBreton = widget.product!.isBreton;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              // The detail row (with image, name, price, ...)
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // The image
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 162),
                        child: ClCard(
                          padding: EdgeInsets.zero,
                          child: Image.asset("assets/images/beer.png"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(child: _buildBasicInfoColumn())
                  ]
                ),
              ),
              const SizedBox(height: 12,),
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
              ),
              const SizedBox(height: 12,),
              Flexible(
                child: ProductCategoriesPicker(
                  initialCategories: widget.product?.categories ?? [],
                  onAddCategory: (category) => _productCategories.add(category),
                  onRemoveCategory: (category) => _productCategories.remove(category),
                ),
              )
            ],
          ),
        ),
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? "Modifier un produit" : "Ajouter un produit"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(ScreenHelper.horizontalPadding),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ClElevatedButton(
                onPressed: () {},
                child: Text(widget.product == null ? "Ajouter mon produit" : "Modifier mon produit"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBasicInfoColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Product name
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

        // Product price with dropdown
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 3,
                child: ClTextInput(
                  controller: _priceTextController,
                  labelText: "Prix",
                  hintText: "Ex : 5,00",
                  validator: (price) {
                    if (int.tryParse(price) == null) return "Vous devez rentrer un nombre valide";

                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12,),
              Flexible(
                flex: 7,
                child: ClDropdown<String>(
                  currentValue: _currentUnit,
                  items: const {
                    "": "Choisir une unitée",
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
              )
            ],
          )
        ),
        const SizedBox(height: 16,),

        // The produit beton checkbox
        ClCheckBox(
          value: _isBreton, 
          text: "Ce produit est Breton",
          onChanged: (value) {
            setState(() {
              _isBreton = value ?? false;
            });
          },
        )
      ],
    );
  }

}