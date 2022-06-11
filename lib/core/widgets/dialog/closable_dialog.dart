import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/dialog/dialog_header.dart';
import 'package:flutter/material.dart';

class ClosableDialog extends StatelessWidget {
  const ClosableDialog({
    Key? key,
    required this.title,
    required this.child,
    this.actions = const []
  }) : super(key: key);

  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1002),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Padding(
          padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The header
              DialogHeader(title: title),
              const SizedBox(height: 12,),

              // The content
              Flexible(
                child: SingleChildScrollView(
                  child: child,
                )
              ),
              const SizedBox(height: 20,),

              // The actions
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}