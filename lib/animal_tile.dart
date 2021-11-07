import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimalTile extends StatelessWidget {
  String name;
  String id;
  String raza;
  String photo;
  DateTime entryDate;
  DateTime birthDate;
  List<int>? age;

  AnimalTile(this.name, this.id, this.raza, this.entryDate,
      [this.photo = 'galgo.png'])
      : birthDate = DateTime.parse("1900-01-01"),
        age = null;
  AnimalTile.withBirthdate(
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
    this.age = _calculateAge(this.birthDate);
    return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      id,
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Llegada: ${DateFormat("dd-MM-yyyy").format(entryDate)}",
                      style: const TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Raza: ${this.raza}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))
                    /*this.age != null
                        ? Text(
                            "Edad:\n${this.age?[0]} años, ${this.age?[1]} meses.",
                            style: const TextStyle(
                                fontSize: 17, color: Colors.grey),
                          )
                        : Text("")*/
                  ],
                ),
                Image.asset(
                  "assets/galgo.png",
                  height: double.infinity,
                ),
              ]),
        ));
  }
}
