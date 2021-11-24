import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './utils.dart';

class AnimalForm extends StatelessWidget {
  final Map<String, String> animalData;
  final List<int> age;

  AnimalForm(
    this.animalData,
  ) : this.age = [0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
              'ID: ${animalData['id'].toString()} - ${animalData['name'].toString()}'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5.0, right: 10.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      elevation: 5,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 40)),
                  onPressed: () {
                    final snackBar = SnackBar(
                      content: const Text(
                          'Acerque el dispositivo a una tarjeta NFC',
                          style: TextStyle(fontSize: 15)),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text('Guardar y enviar a NFC',
                      style: TextStyle(fontSize: 15))),
            ),
            Expanded(
                child: Container(
              height: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ]),
              child: AnimalFormInfo(this.animalData),
            )),
          ],
        ));
  }
}

class AnimalFormInfo extends StatefulWidget {
  final Map<String, String> animalData;

  AnimalFormInfo(this.animalData);
  @override
  _AnimalFormInfoState createState() => _AnimalFormInfoState(this.animalData);
}

class _AnimalFormInfoState extends State<AnimalFormInfo> {
  final Map<String, String> animalData;

  _AnimalFormInfoState(this.animalData);

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
    String name = this.animalData['name'].toString();
    String breed = this.animalData['breed'].toString();
    String photo = this.animalData['photo'].toString();
    String chip = this.animalData['chip'].toString();
    DateTime entryDate =
        DateTime.parse(this.animalData['entryDate'].toString());
    DateTime birthDate;
    List<int>? age;
    String ageStr = '';
    if (this.animalData['birthDate'].toString() != 'null') {
      birthDate = DateTime.parse(this.animalData['birthDate'].toString());
    } else {
      birthDate = DateTime.parse("1900-01-01");
      ageStr = '-';
    }
    if (birthDate != DateTime.parse("1900-01-01")) {
      age = _calculateAge(birthDate);
      ageStr = '${age[0]} años, ${age[1]} meses';
    }
    String description = this.animalData['description'].toString();
    String diseases = this.animalData['diseases'].toString();
    String entryReasons = this.animalData['entryReasons'].toString();
    String notes = this.animalData['notes'].toString();

    return ListView(
      shrinkWrap: true,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimalFormName(name)),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimalFormBreed(breed)),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AnimalFormPhoto(photo)),
            ]),
        Padding(
            padding: const EdgeInsets.all(10.0), child: AnimalFormChip(chip)),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimalFormEntryDate(entryDate)),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimalFormBirthDate(birthDate)),
        Padding(
            padding: const EdgeInsets.all(10.0), child: AnimalFormAge(ageStr)),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimalFormDescription(description)),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimalFormDiseases(diseases)),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimalFormEntryReasons(entryReasons)),
        Padding(
            padding: const EdgeInsets.all(10.0), child: AnimalFormNotes(notes))
      ],
    );
  }
}

class AnimalFormName extends StatefulWidget {
  String name;

  AnimalFormName(this.name);

  @override
  _AnimalFormNameState createState() => _AnimalFormNameState();
}

class _AnimalFormNameState extends State<AnimalFormName> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.name;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 150,
              child: TextField(
                controller: _controller,
                enabled: _isEnable,
              ),
            ),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

//Breed Field
class AnimalFormBreed extends StatefulWidget {
  String breed;

  AnimalFormBreed(this.breed);

  @override
  _AnimalFormBreedState createState() => _AnimalFormBreedState();
}

class _AnimalFormBreedState extends State<AnimalFormBreed> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.breed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Raza',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Container(
              width: 150,
              child: TextField(
                controller: _controller,
                enabled: _isEnable,
              ),
            ),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

//Photo field
class AnimalFormPhoto extends StatefulWidget {
  final String photo;

  AnimalFormPhoto(this.photo);

  @override
  _AnimalFormPhotoState createState() => _AnimalFormPhotoState();
}

class _AnimalFormPhotoState extends State<AnimalFormPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100.0,
        height: 100.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/${widget.photo}'),
                fit: BoxFit.fill)));
  }
}

//Chip field
class AnimalFormChip extends StatefulWidget {
  String chip;

  AnimalFormChip(this.chip);

  @override
  _AnimalFormChipState createState() => _AnimalFormChipState();
}

class _AnimalFormChipState extends State<AnimalFormChip> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.chip;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nº de chip',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: TextField(
                autofocus: true,
                controller: _controller,
                enabled: _isEnable,
              ),
            )),
          ],
        ),
      ],
    );
  }
}

//Entry date field
class AnimalFormEntryDate extends StatefulWidget {
  final DateTime entryDate;

  AnimalFormEntryDate(this.entryDate);

  @override
  _AnimalFormEntryDateState createState() => _AnimalFormEntryDateState();
}

class _AnimalFormEntryDateState extends State<AnimalFormEntryDate> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    String entryDate = DateFormat("dd-MM-yyyy").format(widget.entryDate);
    _controller.text = entryDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Llegada',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: TextField(
                autofocus: true,
                controller: _controller,
                enabled: _isEnable,
              ),
            )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

class AnimalFormBirthDate extends StatefulWidget {
  DateTime birthDate;

  AnimalFormBirthDate(this.birthDate);

  @override
  _AnimalFormBirthDateState createState() => _AnimalFormBirthDateState();
}

class _AnimalFormBirthDateState extends State<AnimalFormBirthDate> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    String birthDate = DateFormat("dd-MM-yyyy").format(widget.birthDate);
    if (birthDate == "01-01-1900") birthDate = '-';
    _controller.text = birthDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha de nacimiento',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: TextField(
                autofocus: true,
                controller: _controller,
                enabled: _isEnable,
              ),
            )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

class AnimalFormAge extends StatefulWidget {
  String age;

  AnimalFormAge(this.age);

  @override
  _AnimalFormAgeState createState() => _AnimalFormAgeState();
}

class _AnimalFormAgeState extends State<AnimalFormAge> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.age;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Edad',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: TextField(
                autofocus: true,
                controller: _controller,
                enabled: _isEnable,
              ),
            )),
          ],
        ),
      ],
    );
  }
}

class AnimalFormDescription extends StatefulWidget {
  String description;

  AnimalFormDescription(this.description);

  @override
  _AnimalFormDescriptionState createState() => _AnimalFormDescriptionState();
}

class _AnimalFormDescriptionState extends State<AnimalFormDescription> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.description;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descripción',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 15,
                controller: _controller,
                enabled: _isEnable,
              ),
            ),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

//Diseases field
class AnimalFormDiseases extends StatefulWidget {
  String diseases;

  AnimalFormDiseases(this.diseases);

  @override
  _AnimalFormDiseasesState createState() => _AnimalFormDiseasesState();
}

class _AnimalFormDiseasesState extends State<AnimalFormDiseases> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.diseases;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enfermedades',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 15,
                controller: _controller,
                enabled: _isEnable,
              ),
            ),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

//Entry Reasons field
class AnimalFormEntryReasons extends StatefulWidget {
  String entryReasons;

  AnimalFormEntryReasons(this.entryReasons);

  @override
  _AnimalFormEntryReasonsState createState() => _AnimalFormEntryReasonsState();
}

class _AnimalFormEntryReasonsState extends State<AnimalFormEntryReasons> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.entryReasons;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motivos de ingreso',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 15,
                controller: _controller,
                enabled: _isEnable,
              ),
            ),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}

class AnimalFormNotes extends StatefulWidget {
  String notes;

  AnimalFormNotes(this.notes);

  @override
  _AnimalFormNotesState createState() => _AnimalFormNotesState();
}

class _AnimalFormNotesState extends State<AnimalFormNotes> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    _controller.text = widget.notes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notas',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 15,
                controller: _controller,
                enabled: _isEnable,
              ),
            ),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _isEnable = false;
                      _editIcon = Icons.edit;
                    } else {
                      _isEnable = true;
                      _editIcon = Icons.edit_off_sharp;
                    }
                  });
                })
          ],
        ),
      ],
    );
  }
}
