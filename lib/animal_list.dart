import 'package:flutter/material.dart';
import './animal_tile.dart';

class AnimalList extends StatelessWidget {
  final List<Map<String, String>> animalsDB;

  AnimalList(this.animalsDB);

  @override
  Widget build(BuildContext context) {
    // Widget ret;
    return ListView(children: [
      ...(animalsDB).map((animalData) {
        return OrientedAnimalTile(animalData);
        // animalData['birthDate'] != null
        //     ? ret = OrientedAnimalTile.withBirthdate(
        //         animalData['name'].toString(),
        //         animalData['id'].toString(),
        //         animalData['breed'].toString(),
        //         DateTime.parse(animalData['entryDate'].toString()),
        //         DateTime.parse(animalData['birthDate'].toString()),
        //         animalData['photo'].toString())
        //     : ret = OrientedAnimalTile(
        //         animalData['name'].toString(),
        //         animalData['id'].toString(),
        //         animalData['breed'].toString(),
        //         DateTime.parse(animalData['entryDate'].toString()),
        //       );
        //return ret;
      })
    ]);
  }
}
