import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../models.dart/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlaces(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        location: null,
        title: title);

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id!,
      'title': newPlace.title!,
      'image': newPlace.image!.path
    });
  }

  Future<void> fetchAndSetData() async {
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            location: null,
            title: e['title'],
          ),
        )
        .toList();

    notifyListeners();
  }
}
