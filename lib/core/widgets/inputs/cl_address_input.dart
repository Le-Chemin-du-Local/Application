import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/place/place_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ClAddressInput extends StatefulWidget {
  const ClAddressInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.addressTextController,
    this.onSelected
  }) : super(key: key);

  final String label;
  final String hint;

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
    return LayoutBuilder(
      builder: (context, constraints) {
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
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
                  side: BorderSide(
                    color: Colors.grey
                  )
                ),
                color: Theme.of(context).colorScheme.surface,
                elevation: 6,
                child: SizedBox(
                  height: 52.0 * options.length,
                  width: constraints.biggest.width, // <-- Right here !
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    shrinkWrap: false,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(option),
                        ),
                      );
                    },
                  ),
                ),
              )
            );
          },
          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
            return ClTextInput(
              controller: textEditingController,
              focusNode: focusNode, 
              labelText: widget.label,
              hintText: widget.hint,
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
    );
  }
}