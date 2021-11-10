import 'package:flutter/material.dart';
import './portrait_animal_tile.dart';
import './landscape_animal_tile.dart';

class OrientedAnimalTile extends StatelessWidget {
  final String name;
  final String id;
  final String raza;
  final String photo;
  final DateTime entryDate;
  final DateTime birthDate;
  List<int>? age;

  OrientedAnimalTile(this.name, this.id, this.raza, this.entryDate,
      [this.photo = 'galgo.png'])
      : birthDate = DateTime.parse("1900-01-01"),
        age = null;
  OrientedAnimalTile.withBirthdate(
      this.name, this.id, this.raza, this.entryDate, this.birthDate,
      [this.photo = 'galgo.png'])
      : age = null;

  List<int> _calculateAge(DateTime birthDate) {
    final now = new DateTime.now();

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years--;
      months += (days < 0 ? 11 : 12);
    }

    if (days < 0) {
      final monthAgo = new DateTime(now.year, now.month - 1, birthDate.day);
      days = now.difference(monthAgo).inDays + 1;
    }

    return [years, months];
  }

  @override
  Widget build(BuildContext context) {
    if (this.birthDate != DateTime.parse("1900-01-01"))
      this.age = _calculateAge(this.birthDate);

    return OrientationBuilder(builder: (context, orientation) {
      return orientation == Orientation.portrait
          ? PortraitAnimalTile(this.name, this.id, this.raza, this.entryDate,
              this.birthDate, this.age)
          : LandscapeAnimalTile(this.name, this.id, this.raza, this.entryDate,
              this.birthDate, this.age);
    });
  }
}
