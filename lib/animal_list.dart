import 'package:flutter/material.dart';
import 'package:galgo/animal.dart';
import './animal_tile.dart';

class AnimalList extends StatelessWidget {
  final List<Animal> animalsList;

  AnimalList(this.animalsList);

  @override
  Widget build(BuildContext context) {
    // Widget ret;
    return ListView(children: [
      ...(animalsList).map((animalData) {
        return OrientedAnimalTile(animalData);
      })
    ]);
  }
}
