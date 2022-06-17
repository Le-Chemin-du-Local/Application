import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/header_profile_picture.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    Key? key,
    required this.storekeeperWord,
    required this.commerceID,
    this.canEdit = false,
  }) : super(key: key);

  final String storekeeperWord;

  final String? commerceID;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    const double height = 360.0;

    return SliverAppBar(
      pinned: false,
      expandedHeight: height - 90, // On doit enlever 90 pour compenser l'appbar
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Theme.of(context).disabledColor,
          child: Stack(
            children: [
              // La photo de fond
              SizedBox(
                height: height,
                width: double.infinity,
                child: Image.network(
                  "$kImagesBaseUrl/commerces/${commerceID ?? ""}/header.jpg",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                    ),
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.image, size: 92, color: Theme.of(context).colorScheme.error,);
                  },
                )
              ),

              // Le gradient permettant de voir le mot du commerçant
              Container(
                height: height,
                decoration: const BoxDecoration(
                  gradient: Palette.gradientBlackCover
                ),
              ),

              // Le mot du commerçant
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // La photo de profil
                      HeaderProfilePicture(
                        commerceID: commerceID,
                        canEdit: canEdit,
                      ),
                      const SizedBox(width: 12,),

                      // Le mot en lui même 
                      Flexible(
                        child: Text(
                          storekeeperWord, 
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Palette.colorWhite
                          )
                        ),
                      )
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}