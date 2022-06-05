import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/place/place_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ClAddressInput extends StatefulWidget {
  const ClAddressInput({
    Key? key,
    required this.addressTextController,
    this.onSelected
  }) : super(key: key);

  final TextEditingController addressTextController;
  final Function(String)? onSelected;

  @override
  State<ClAddressInput> createState() => _ClAddressInputState();
}

class _ClAddressInputState extends State<ClAddressInput> {
  final FocusNode _focusNode = FocusNode();

  String _sessionToken = "";

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: widget.addressTextController,
      focusNode: _focusNode,
      onSelected: widget.onSelected,
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
          labelText: "Adresse de votre commerce",
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
    );
  }
}