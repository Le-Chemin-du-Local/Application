import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class PageHeaderImage extends StatelessWidget {
  const PageHeaderImage({
    Key? key,
    required this.commerceID,
  }) : super(key: key);

  final String commerceID;

  @override
  Widget build(BuildContext context) {
    const double height = 242.0;

    return Container(
      color: Theme.of(context).disabledColor,
      child: Stack(
        children: [
          SizedBox(
            height: height,
            width: double.infinity,
            child: Image.network(
              "$kImagesBaseUrl/commerces/headers/$commerceID.jpg",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                ),
              ),
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image, size: 92, color: Theme.of(context).dividerColor,);
              },
            )
          ),
          Container(
            height: height,
            decoration: const BoxDecoration(
              gradient: Palette.gradientBlackCover
            ),
          )
        ],
      ),
    );   
  }
}