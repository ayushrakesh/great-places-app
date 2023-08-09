import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../providers/great_places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();
  File? savedimage;

  void selectImage(File selectedImage) {
    savedimage = selectedImage;
  }

  void savePlace() {
    if (titleController.text.isEmpty || savedimage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlaces(titleController.text, savedimage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Places',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(
              10,
            ),
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: savePlace,
            child: Text(
              '+  Add Place',
            ),
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
