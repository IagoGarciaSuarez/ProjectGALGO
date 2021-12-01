import 'package:flutter/material.dart';
import 'package:galgo/animal.dart';
import './animal_tile.dart';

class AnimalList extends StatelessWidget {
  final List<Animal> animalsDB;

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
