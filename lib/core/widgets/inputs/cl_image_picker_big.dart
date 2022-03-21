import 'dart:convert';
import 'dart:typed_data';

import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ClImagePickerBig extends StatefulWidget {
  const ClImagePickerBig({
    Key? key,
    required this.imageURL,
    required this.onImageSelected,
    this.imageData
  }) : super(key: key);

  final String imageURL;
  final ClFile? imageData;

  final Function(ClFile) onImageSelected;

  @override
  State<ClImagePickerBig> createState() => _ClImagePickerBigState();
}

class _ClImagePickerBigState extends State<ClImagePickerBig> {
  ClFile? _image;

  @override
  void initState() {
    super.initState();

    _image = widget.imageData;
  }

  @override
  void didUpdateWidget(covariant ClImagePickerBig oldWidget) {
    super.didUpdateWidget(oldWidget);

    _image = widget.imageData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dividerColor,
      height: 180,
      child: Stack(
        children: [
          // If the image already exists
          if (_image != null)
            Positioned.fill(
              child: Image.memory(
                  base64Decode(_image!.base64content!),
                  fit: BoxFit.cover,
              ),
            )
          else 
            // If the image doesn't exist
            Positioned.fill(
              child: Image.network(
                widget.imageURL,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  ),
                ),
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(height: 250,);
                },
              ),
            ),

          // The add button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClElevatedButton(
                onPressed: _pickImage,
                child: const Text("Ajouter"),
              ),
            ),
          )
        ],
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

      widget.onImageSelected(file);

      setState(() {
        _image = file;
      });
    }

  } 
}