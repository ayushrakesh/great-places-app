import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function selectImage;

  ImageInput(this.selectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? imageStored;

  Future<void> pickImage() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      imageStored = imageFile;
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: imageStored != null
              ? Image.file(
                  imageStored!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(
          width: 60,
        ),
        Expanded(
          child: FlatButton(
            onPressed: pickImage,
            child: Row(
              children: [
                Icon(
                  Icons.camera,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Take picture',
                ),
              ],
            ),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
