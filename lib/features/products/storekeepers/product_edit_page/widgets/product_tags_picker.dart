import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/dialog/closable_dialog.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:flutter/material.dart';

class ProductTagsPicker extends StatelessWidget {
  const ProductTagsPicker({
    Key? key, 
    required this.tags, 
    required this.onTagAdded, 
    required this.onTagRemoved
  }) : super(key: key);

  final List<String> tags;

  final Function(String) onTagAdded;
  final Function(String) onTagRemoved;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Tags spécifiques", 
          style: ScreenHelper.instance.isMobile 
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.headlineSmall
        ),
        const SizedBox(height: 10,),

        Flexible(
          child: Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              for (final tag in tags) 
                _buildTag(context, tag),
        
              InkWell(
                onTap: () => _addTag(context),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    border: Border.all(color: Theme.of(context).colorScheme.secondary),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Text(
                      "Ajouter un tag",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildTag(BuildContext context, String tag) {
    return InkWell(
      onTap: () => onTagRemoved(tag),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "#$tag",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary
                  ),
                ),
              ),
              const SizedBox(width: 8,),
    
              Icon(
                Icons.delete,
                size: 16,
                color: Theme.of(context).colorScheme.onSecondary,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _addTag(BuildContext context) async {
    final TextEditingController tagTextController = TextEditingController();

    await showDialog<String?>(
      context: context, 
      builder: (context) => ClosableDialog(
        title: "Choisir le tag", 
        child: ClTextInput(
          controller: tagTextController,
          labelText: "Nom du tag",
          hintText: "biere",
          validator: null,
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(), 
            child: const Text("Valider")
          )
        ], 
      )
    ); 

    if (tagTextController.text.isNotEmpty) {
      onTagAdded(tagTextController.text.replaceAll("#", ""));
    }
  }
}