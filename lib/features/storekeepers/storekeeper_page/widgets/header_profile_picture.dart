import 'dart:convert';

import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

class HeaderProfilePicture extends StatelessWidget {
  const HeaderProfilePicture({
    Key? key,
    this.commerceID,
    this.canEdit = false,
  }) : super(key: key);

  final String? commerceID;
  final bool canEdit;

  MutationOptions _updateCommerceMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateStorekeerCommercePage),
    );
  }

  @override
  Widget build(BuildContext context) {
    // La photo de profil
    return Mutation<dynamic>(
      options: _updateCommerceMutationOptions(),
      builder: (runMutation, mutationResult) {
        // Si ça charge
        if (mutationResult?.isLoading ?? false) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(60)
            ),
            width: 120, height: 120,
            child: const Center(child: CircularProgressIndicator(),),
          );
        }

        // Si on a une erreur
        if (mutationResult?.hasException ?? false) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(60)
            ),
            width: 120, height: 120,
            child: Center(
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
                size: 48,
              ),
            ),
          );
        }

        return ClImagePicker(
          imageURL: "$kImagesBaseUrl/commerces/${commerceID ?? ""}/profile.jpg", 
          onImageSelected: (image) => _onProfilePictureSelected(runMutation, image),
          showEditButton: canEdit,
          size: 120,
        );
      }
    );
  }

  Future _onProfilePictureSelected(RunMutation runMutation, ClFile image) async {
    runMutation(<String, dynamic>{
      "id": commerceID,
      "changes": <String, dynamic>{
        "profilePicture": MultipartFile.fromBytes(
          "profilePicture",
          base64Decode(image.base64content!),
          filename: image.filename
        ),
      }  
    });
  }
}