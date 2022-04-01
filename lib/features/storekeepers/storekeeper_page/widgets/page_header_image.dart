import 'dart:convert';
import 'dart:typed_data';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PageHeaderImage extends StatelessWidget {
  const PageHeaderImage({
    Key? key,
    required this.storekeeperWordTextController,
    required this.commerceID,
    required this.onImageSelected,
    required this.onProfilePictureSelected,
    required this.isEditing,
    this.errorMessage = "",
    this.imageData,
    this.profilePictureData,
  }) : super(key: key);

  final TextEditingController storekeeperWordTextController;

  final String errorMessage;

  final String? commerceID;
  final ClFile? imageData;
  final ClFile? profilePictureData;

  final Function(ClFile) onImageSelected;
  final Function(ClFile) onProfilePictureSelected;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    const double height = 360.0;

    return SliverAppBar(
      pinned: false,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Theme.of(context).disabledColor,
          child: Stack(
            children: [
              // La photo de fond
              SizedBox(
                height: height,
                width: double.infinity,
                child: imageData == null 
                  ? Image.network(
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
                        return Icon(Icons.image, size: 92, color: Theme.of(context).dividerColor,);
                      },
                    )
                  : Image.memory(
                      base64Decode(imageData!.base64content!),
                      fit: BoxFit.cover,
                    )
              ),
              // Le graadient
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
                    padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // La photo de profile
                      ClImagePicker(
                        imageURL: "$kImagesBaseUrl/commerces/${commerceID ?? ""}/profile.jpg", 
                        imageData: profilePictureData,
                        onImageSelected: onProfilePictureSelected,
                        showEditButton: isEditing,
                        size: 120,
                      ),
                      const SizedBox(width: 12,),
                      Flexible(
                        child: isEditing 
                          ? ClTextInput(
                              controller: storekeeperWordTextController,
                              labelText: "Le mot du commerçant",
                              hintText: "Rentrez une phrase pour attirer vos futures clients",
                              validator: (value) {
                                if (value.isEmpty) return "Vous devez rentrer une valeur";
                                return null;
                              },
                            )
                          : Text(
                              storekeeperWordTextController.text,
                              style: TextStyle(color: Palette.colorWhite),
                            )
                      ),
                    ],
                  ),
                ),
              ),
              if (isEditing)
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: _pickImage
                    ),
                  ),
                ),

              // Le message d'erreur si besoin
              if (errorMessage.isNotEmpty) 
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
                    child: ClStatusMessage(message: errorMessage),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true
    );

    if (result != null) {
      final Uint8List bytes = result.files.first.bytes!;
      final String fileName = result.files.first.name;

      final ClFile file = ClFile(
        base64content: base64Encode(bytes),
        filename: fileName
      );

      onImageSelected(file);
      imageCache?.clear();
    }
  } 
}