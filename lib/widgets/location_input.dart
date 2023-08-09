import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? previewImageUrl;

  Future<void> getUserCurrentLocatoin() async {
    final locData = await Location().getLocation();
    print(locData);
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          height: 160,
          width: double.infinity,
          child: previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  previewImageUrl!,
                ),
        ),
        Row(
          children: [
            TextButton(
              onPressed: getUserCurrentLocatoin,
              child: Text(
                'Current Location',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Location Input',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
