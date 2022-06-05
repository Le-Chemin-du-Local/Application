import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/place/models/address/address.dart';
import 'package:chemin_du_local/place/place_service.dart';
import 'package:chemin_du_local/place/widgets/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({
    Key? key,
    required this.addressController,
    this.onSelected
  }) : super(key: key);

  final Function(Address)? onSelected;

  final AddressController addressController;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final FocusNode _focusNode = FocusNode();

  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _optionalRouteTextController = TextEditingController();
  final TextEditingController _postalCodeTextController = TextEditingController();
  final TextEditingController _cityTextController = TextEditingController();

  String _sessionToken = "";

  void _initialize() {
    _addressTextController.text = "${widget.addressController.address.number ?? ""} ${widget.addressController.address.route ?? ""}";
    _optionalRouteTextController.text = widget.addressController.address.optionalRoute ?? "";
    _postalCodeTextController.text = widget.addressController.address.postalCode ?? "";
    _cityTextController.text = widget.addressController.address.city ?? "";
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant AddressForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: RawAutocomplete<String>(
            textEditingController: _addressTextController,
            focusNode: _focusNode,
            onSelected: (value) async {
              final Address? address = await PlaceAPIProvider.instance.detailsForAddress(value);
        
              if (address != null) {
                if (widget.onSelected != null) {
                  widget.onSelected!(address);
                }

                widget.addressController.address = address;
        
                _addressTextController.text = "${address.number ?? ""} ${address.route ?? ""}";
                _optionalRouteTextController.text = "";
                _postalCodeTextController.text = address.postalCode ?? "";
                _cityTextController.text = address.city ?? "";
                _focusNode.unfocus();
              }
            },
            optionsBuilder: (textEditingValue) async {
              final List<Suggestion> suggestions = await PlaceAPIProvider.instance.fetchSuggestions(textEditingValue.text, "fr", _sessionToken);
        
              final List<String> result = [
                for (final suggestion in suggestions)
                  suggestion.description
              ];
        
              return result;
            },
            optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
              return Material(
                elevation: 4.0,
                child: ListView(
                  children: [
                    for (final option in options)
                      InkWell(
                        onTap: () => onSelected(option),
                        child: ListTile(
                          title: Text(option),
                        ),
                      )
                  ],
                ),
              );
            },
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
              return ClTextInput(
                controller: textEditingController,
                focusNode: focusNode, 
                labelText: "Adresse",
                hintText: "Rentrer une adresse",
                onTap: () {
                  _sessionToken = const Uuid().v4();
                },
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer une adresse";
        
                  return null;
                },
              );
            },
          ),
        ),
        const SizedBox(height: 18,),

        // Le complément d'adresse
        Flexible(
          child: ClTextInput(
            controller: _optionalRouteTextController,
            labelText: "Complément d'adresse",
            hintText: "Appartement 10",
            onChanged: (value) {
              widget.addressController.address = widget.addressController.address.copyWith(
                optionalRoute: value
              );
            },
            validator: null,
          ),
        ),
        const SizedBox(height: 18,),

        Flexible(
          child: Row(
            children: [
              // Le code postal
              Flexible(
                child: ClTextInput(
                  controller: _postalCodeTextController,
                  labelText: "Code postal",
                  hintText: "35000",
                  onTap: _focusNode.requestFocus,
                  validator: (value) {
                    if (value.isEmpty) return "Il doit y avoir un code postal...";
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 15,),

              // La ville
              Flexible(
                child: ClTextInput(
                  controller: _cityTextController,
                  labelText: "Ville",
                  hintText: "Rennes",
                  onTap: _focusNode.requestFocus,
                  validator: (value) {
                    if (value.isEmpty) return "Il doit y avoir une ville...";
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
}