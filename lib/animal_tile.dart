import 'package:flutter/material.dart';
import './portrait_animal_tile.dart';
import './landscape_animal_tile.dart';
import './animal.dart';

class OrientedAnimalTile extends StatelessWidget {
  final Animal animalData;
  List<int>? age;

  // final String name;
  // final String id;
  // final String raza;
  // final String photo;
  // final DateTime entryDate;
  // final DateTime birthDate;
  // List<int>? age;

  OrientedAnimalTile(this.animalData) : age = null;
  // this.name, this.id, this.raza, this.entryDate,
  //   [this.photo = 'galgo.png'])
  //   : birthDate = DateTime.parse("1900-01-01"),
  //     age = null;
  // OrientedAnimalTile.withBirthdate(this.animalData): age = null;
  // // this.name, this.id, this.raza, this.entryDate, this.birthDate,
  // // [this.photo = 'galgo.png'])
  // // : age = null;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? PortraitAnimalTile(this.animalData)
          : PortraitAnimalTile(this.animalData);
      //LandscapeAnimalTile(this.animalData);
    });
  }
}
