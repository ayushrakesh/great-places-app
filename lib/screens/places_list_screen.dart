import 'package:flutter/material.dart';
import '../providers/great_places.dart';
import '../screens/add-place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPlaceScreen.routeName,
              );
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchAndSetData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (context, great_places_data, ch) =>
                    great_places_data.items.length <= 0
                        ? Center(
                            child: Text(
                              'No Places added yet! Try adding some',
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: ((context, index) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: FileImage(
                                        great_places_data.items[index].image!),
                                  ),
                                  title: Text(
                                      great_places_data.items[index].title!),
                                  onTap: () {},
                                )),
                            itemCount: great_places_data.items.length,
                          ),
              ),
      ),
    );
  }
}
