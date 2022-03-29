import 'dart:convert';
import 'dart:typed_data';

import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ClImagePicker extends StatefulWidget {
  const ClImagePicker({
    Key? key,
    required this.imageURL,
    required this.onImageSelected,
    this.imageData,
    this.showEditButton = true,
    this.size = 92
  }) : super(key: key);

  final String imageURL;
  final ClFile? imageData;

  final Function(ClFile) onImageSelected;

  final bool showEditButton;
  final double size;
  
  @override
  State<ClImagePicker> createState() => _ClImagePickerState();
}

class _ClImagePickerState extends State<ClImagePicker> {
  ClFile? _image;

  @override
  void initState() {
    super.initState();

    _image = widget.imageData;
  }

  @override
  void didUpdateWidget(covariant ClImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    _image = widget.imageData;
  }

  @override
  Widget build(BuildContext context) {
    // First case, we selected an image
    return Stack(
      children: [
        if (_image != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.size / 2),
            child: Container(
              height: widget.size, width: widget.size,
              color: Theme.of(context).dividerColor,
              child: Image.memory(
                base64Decode(_image!.base64content!),
                fit: BoxFit.cover,
              )
            )
          )
        else 
          ClipRRect(
          borderRadius: BorderRadius.circular(widget.size / 2),
          child: Container(
            height: widget.size, width: widget.size,
            color: Theme.of(context).dividerColor,
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
                return Container(
                  width: widget.size, height: widget.size,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Icon(Icons.image, size: widget.size * 0.5,),
                );
              },
            ),
          )
        ),
        if (widget.showEditButton)
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: _pickImage,
                iconSize: 14,
                icon: const Icon(Icons.edit, color: Palette.colorWhite,),
              ),
            ),
          )
      ],
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