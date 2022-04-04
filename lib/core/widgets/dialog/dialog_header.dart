import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:flutter/material.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    Key? key,
    required this.title,
    this.onClose,
  }) : super(key: key);

  final String title;

  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The title
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.headline2,),
          ),
          const SizedBox(width: 8.0,),

          // The closing button
          IconButton(
            icon: const Icon(Icons.close),
            iconSize: 22,
            color: Theme.of(context).textTheme.bodyText1!.color,
            onPressed: () {
              if (onClose != null) {
                onClose!();
              } 
              else {
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}