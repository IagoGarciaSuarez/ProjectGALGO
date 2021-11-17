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
      })
    ]);
  }
}
