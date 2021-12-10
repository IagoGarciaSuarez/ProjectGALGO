import 'package:flutter/material.dart';
import './portrait_animal_tile.dart';
import './landscape_animal_tile.dart';
import './animal.dart';

class OrientedAnimalTile extends StatelessWidget {
  final Animal animalData;
  OrientedAnimalTile(this.animalData);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? PortraitAnimalTile(this.animalData)
        : LandscapeAnimalTile(this.animalData);
  }
}
