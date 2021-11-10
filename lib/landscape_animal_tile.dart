import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './animal_form_display.dart';

class LandscapeAnimalTile extends StatelessWidget {
  final String name;
  final String id;
  final String raza;
  final String photo;
  final DateTime entryDate;
  final DateTime birthDate;
  List<int>? age;

  LandscapeAnimalTile(
      this.name, this.id, this.raza, this.entryDate, this.birthDate, this.age,
      [this.photo = 'galgo.png']);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AnimalFormDisplay(this.id)),
          );
        },
        child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                          style:
                              const TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Llegada: ${DateFormat("dd-MM-yyyy").format(entryDate)}",
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        this.age != null
                            ? Text(
                                "Edad:${this.age?[0]} años, ${this.age?[1]} meses.",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.grey),
                              )
                            : Text("")
                      ],
                    ),
                    Text("Raza: ${this.raza}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Container(
                        width: 20.0,
                        height: 20.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/galgo.png'),
                                fit: BoxFit.fill)))
                  ]),
            )));
  }
}
