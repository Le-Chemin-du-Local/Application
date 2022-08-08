import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:flutter/material.dart';

class ClAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClAppBar({
    Key? key, 
    this.forceShowMenuButton = false,
    required this.canPop,
    this.onShowDrawer,
    this.title,
    this.backgroundColor,
    this.actions,
    this.height = 80
  }) : super(key: key);

  final bool forceShowMenuButton;
  final bool canPop;

  final double height;
  final Widget? title;
  final Color? backgroundColor;
  final List<Widget>? actions;

  final Function()? onShowDrawer;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.instance.horizontalPadding
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leadingWidth: (forceShowMenuButton || onShowDrawer != null) && !ScreenHelper.instance.isMobile
          ? 116 + (canPop ? 48 : 0)
          : canPop ? 48 : 0,
        toolbarHeight: height,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if ((forceShowMenuButton || onShowDrawer != null) && !ScreenHelper.instance.isMobile) ...{
              ElevatedButton.icon(
                onPressed: onShowDrawer, 
                icon: const Icon(Icons.menu),
                label: const Text("Menu")
              ),
              const SizedBox(width: 8,)
            },

            if (canPop)
              const BackButton()
          ],
        ),
        title: title,
        backgroundColor: backgroundColor,
        actions: actions,
      ),
    );
  }
}