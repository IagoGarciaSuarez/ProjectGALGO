import 'package:flutter/material.dart';
import 'package:galgo/animal.dart';
import 'package:intl/intl.dart';
import './utils.dart';

late Animal gAnimalData;

class AnimalForm extends StatelessWidget {
  final Animal animalData;
  final List<int> age;

  AnimalForm(
    this.animalData,
  ) : this.age = [0, 0];

  @override
  Widget build(BuildContext context) {
    gAnimalData = this.animalData.cloneAnimal();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('ID: ${gAnimalData.id} - ${gAnimalData.name}'),
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
                    WriteNFC(gAnimalData.toJson()).then((r) {
                      final snackBar = SnackBar(
                        content: Text('Acerce el dispositivo a una tarjeta NFC',
                            style: TextStyle(fontSize: 15)),
                      );
                      if (r.containsKey('error')) {
                        SnackBar(
                          content:
                              Text(r['error'], style: TextStyle(fontSize: 15)),
                        );

                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
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
              child: AnimalFormInfo(),
            )),
          ],
        ));
  }
}

class AnimalFormInfo extends StatefulWidget {
  AnimalFormInfo();
  @override
  _AnimalFormInfoState createState() => _AnimalFormInfoState();
}

class _AnimalFormInfoState extends State<AnimalFormInfo> {
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
    DateTime entryDate = DateTime.parse(gAnimalData.entryDate);
    DateTime birthDate;
    List<int>? age;
    String ageStr = '';
    if (gAnimalData.birthDate != 'null') {
      birthDate = DateTime.parse(gAnimalData.birthDate);
    } else {
      birthDate = DateTime.parse("1900-01-01");
      ageStr = '-';
    }
    if (birthDate != DateTime.parse("1900-01-01")) {
      age = _calculateAge(birthDate);
      ageStr = '${age[0]} años, ${age[1]} meses';
    }

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
                      child: AnimalFormName()),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: AnimalFormBreed()),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: AnimalFormPhoto()),
            ]),
        Padding(padding: const EdgeInsets.all(10.0), child: AnimalFormChip()),
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
            child: AnimalFormDescription()),
        Padding(
            padding: const EdgeInsets.all(10.0), child: AnimalFormDiseases()),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimalFormEntryReasons()),
        Padding(padding: const EdgeInsets.all(10.0), child: AnimalFormNotes())
      ],
    );
  }
}

class AnimalFormName extends StatefulWidget {
  @override
  _AnimalFormNameState createState() => _AnimalFormNameState();
}

class _AnimalFormNameState extends State<AnimalFormName> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: gAnimalData.name,
                    enabled: _isEnable,
                    onSaved: (val) {
                      gAnimalData.name = val!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                    onChanged: (value) => _formKey.currentState!.validate(),
                  ),
                )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _isEnable = false;
                        _editIcon = Icons.edit;
                      }
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
  @override
  _AnimalFormBreedState createState() => _AnimalFormBreedState();
}

class _AnimalFormBreedState extends State<AnimalFormBreed> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Desconocido',
                    ),
                    initialValue: gAnimalData.breed,
                    enabled: _isEnable,
                    onSaved: (val) {
                      if (val == '') {
                        gAnimalData.breed = 'Desconocido';
                      }
                    },
                  ),
                )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _formKey.currentState!.save();
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
                image: AssetImage('assets/${gAnimalData.photo}'),
                fit: BoxFit.fill)));
  }
}

//Chip field
class AnimalFormChip extends StatefulWidget {
  @override
  _AnimalFormChipState createState() => _AnimalFormChipState();
}

class _AnimalFormChipState extends State<AnimalFormChip> {
  @override
  Widget build(BuildContext context) {
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
                  child: TextFormField(
                initialValue: gAnimalData.chip,
                enabled: false,
              )),
            ),
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
  _AnimalFormEntryDateState createState() =>
      _AnimalFormEntryDateState(this.entryDate);
}

class _AnimalFormEntryDateState extends State<AnimalFormEntryDate> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  DateTime entryDate;
  late String entryDateStr;

  _AnimalFormEntryDateState(this.entryDate)
      : entryDateStr = DateFormat("dd-MM-yyyy").format(entryDate);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: entryDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != entryDate)
      setState(() {
        entryDate = picked;
        entryDateStr = DateFormat("dd-MM-yyyy").format(entryDate);
        _controller.text = entryDateStr;
      });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = entryDateStr;

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
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
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
  _AnimalFormBirthDateState createState() =>
      _AnimalFormBirthDateState(this.birthDate);
}

class _AnimalFormBirthDateState extends State<AnimalFormBirthDate> {
  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;
  DateTime birthDate;
  late String birthDateStr;

  _AnimalFormBirthDateState(this.birthDate)
      : birthDateStr = DateFormat("dd-MM-yyyy").format(birthDate);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: birthDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
        birthDateStr = DateFormat("dd-MM-yyyy").format(birthDate);
        _controller.text = birthDateStr;
      });
  }

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
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
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
  @override
  _AnimalFormDescriptionState createState() => _AnimalFormDescriptionState();
}

class _AnimalFormDescriptionState extends State<AnimalFormDescription> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                child: Form(
              key: _formKey,
              child: TextFormField(
                minLines: 1,
                maxLines: 15,
                decoration: const InputDecoration(
                  hintText: '-',
                ),
                initialValue: gAnimalData.description,
                enabled: _isEnable,
                onSaved: (val) {
                  if (val == '') {
                    gAnimalData.description = '-';
                  }
                },
              ),
            )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _formKey.currentState!.save();
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
  @override
  _AnimalFormDiseasesState createState() => _AnimalFormDiseasesState();
}

class _AnimalFormDiseasesState extends State<AnimalFormDiseases> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                child: Form(
              key: _formKey,
              child: TextFormField(
                minLines: 1,
                maxLines: 15,
                decoration: const InputDecoration(
                  hintText: '-',
                ),
                initialValue: gAnimalData.diseases,
                enabled: _isEnable,
                onSaved: (val) {
                  if (val == '') {
                    gAnimalData.diseases = '-';
                  }
                },
              ),
            )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _formKey.currentState!.save();
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
  @override
  _AnimalFormEntryReasonsState createState() => _AnimalFormEntryReasonsState();
}

class _AnimalFormEntryReasonsState extends State<AnimalFormEntryReasons> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                child: Form(
              key: _formKey,
              child: TextFormField(
                minLines: 1,
                maxLines: 15,
                decoration: const InputDecoration(
                  hintText: '-',
                ),
                initialValue: gAnimalData.entryReasons,
                enabled: _isEnable,
                onSaved: (val) {
                  if (val == '') {
                    gAnimalData.entryReasons = '-';
                  }
                },
              ),
            )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _formKey.currentState!.save();
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
  @override
  _AnimalFormNotesState createState() => _AnimalFormNotesState();
}

class _AnimalFormNotesState extends State<AnimalFormNotes> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                child: Form(
              key: _formKey,
              child: TextFormField(
                minLines: 1,
                maxLines: 15,
                decoration: const InputDecoration(
                  hintText: '-',
                ),
                initialValue: gAnimalData.notes,
                enabled: _isEnable,
                onSaved: (val) {
                  if (val == '') {
                    gAnimalData.notes = '-';
                  }
                },
              ),
            )),
            IconButton(
                icon: Icon(_editIcon),
                onPressed: () {
                  setState(() {
                    if (_isEnable == true) {
                      _formKey.currentState!.save();
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
