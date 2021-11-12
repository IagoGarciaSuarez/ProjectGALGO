import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './animal_form.dart';

class LandscapeAnimalTile extends StatelessWidget {
  final Map<String, String> animalData;

  LandscapeAnimalTile(this.animalData);
  // PortraitAnimalTile(this.name, this.id, this.raza, this.entryDate,
  //     this.birthDate, this.age, this.photo);

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
    final String name = animalData['name'].toString();
    final String id = this.animalData['id'].toString();
    final String breed = this.animalData['breed'].toString();
    final String photo = this.animalData['photo'].toString();
    final DateTime entryDate =
        DateTime.parse(this.animalData['entryDate'].toString());
    DateTime birthDate;
    List<int>? age;

    if (this.animalData['birthDate'].toString() != 'null') {
      birthDate = DateTime.parse(this.animalData['birthDate'].toString());
    } else
      birthDate = DateTime.parse("1900-01-01");

    if (birthDate != DateTime.parse("1900-01-01"))
      age = _calculateAge(birthDate);

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimalForm(this.animalData)),
          );
        },
        child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        Text("Raza: ${breed}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        age != null
                            ? Text(
                                "Edad:${age[0]} años, ${age[1]} meses.",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.grey),
                              )
                            : Text("")
                      ],
                    ),
                    Container(
                        width: 100.0,
                        height: 100.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/galgo.png'),
                                fit: BoxFit.fill)))
                  ]),
            )));
  }
}
