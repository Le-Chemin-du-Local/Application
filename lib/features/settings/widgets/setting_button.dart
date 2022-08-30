import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.page
  }) : super(key: key);

  final IconData icon;
  final String title;

  final Widget page;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (context) => page
          )
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding,
          vertical: 16
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(color: Theme.of(context).colorScheme.outline, width: 0.5),
            bottom: BorderSide(color: Theme.of(context).colorScheme.outline, width: 0.5)
          )
        ),
        child: Row(
          children: [
            Icon(icon, size: 21),
            const SizedBox(width: 12,),
    
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.bodyLarge,),
            ),
            const SizedBox(width: 12,),
    
            const Icon(Icons.arrow_forward_ios, size: 16,)
          ],
        ),
      ),
    );
  }
}