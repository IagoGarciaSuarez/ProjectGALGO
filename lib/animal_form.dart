import 'package:flutter/material.dart';
import 'package:galgo/animal.dart';
import 'package:intl/intl.dart';
import './utils.dart';

late Animal gAnimalData;
TextEditingController _ageController = TextEditingController();

class AnimalForm extends StatefulWidget {
  final Animal animalData;
  final List<int> age;
  AnimalForm(
    this.animalData,
  ) : this.age = [0, 0];

  @override
  _AnimalFormState createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  final JsonAccess jsonFile = new JsonAccess();

  @override
  Widget build(BuildContext context) {
    gAnimalData = widget.animalData.cloneAnimal();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('${gAnimalData.name}'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0, left: 10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(
                            (MediaQuery.of(context).size.width / 2) - 20, 40)),
                    onPressed: () {
                      jsonFile.readAnimalData().then((data) {
                        data[gAnimalData.id] =
                            gAnimalData.toJson()[gAnimalData.id];
                        jsonFile.writeAnimalData(data);
                      });
                      final snackBar = SnackBar(
                        content: Text('Acerce el dispositivo a una tarjeta NFC',
                            style: TextStyle(fontSize: 15)),
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      writeNFC(gAnimalData.toJson()).then((r) {
                        final snackBar = SnackBar(
                          content: Text('Escritura realizada',
                              style: TextStyle(fontSize: 15)),
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                    child: Text('Guardar y enviar a NFC',
                        style: TextStyle(fontSize: 15))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0, right: 10.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        elevation: 5,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        minimumSize: Size(
                            (MediaQuery.of(context).size.width / 2) - 20, 40)),
                    onPressed: () {
                      jsonFile.readAnimalData().then((data) {
                        data[gAnimalData.id] =
                            gAnimalData.toJson()[gAnimalData.id];
                        jsonFile.writeAnimalData(data);
                      });
                      final snackBar = SnackBar(
                        content: Text('Cambios guardados localmente.',
                            style: TextStyle(fontSize: 15)),
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text('Guardar', style: TextStyle(fontSize: 15))),
              )
            ]),
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
  @override
  Widget build(BuildContext context) {
    DateTime entryDate = DateTime.parse(gAnimalData.entryDate);
    DateTime birthDate;
    List<int>? age;
    String ageStr = '';

    if (gAnimalData.birthDate != '-') {
      birthDate = DateTime.parse(gAnimalData.birthDate);
    } else {
      birthDate = DateTime.parse("1900-01-01");
      ageStr = '-';
    }
    if (birthDate != DateTime.parse("1900-01-01")) {
      age = calculateAge(birthDate);
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
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0),
                      child: AnimalFormName()),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0),
                      child: AnimalFormBreed()),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 10,
                        ),
                        child: AnimalFormCell()),
                    Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: AnimalFormPhoto()),
                  ]),
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
                width: 120,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: gAnimalData.name,
                    enabled: _isEnable,
                    onSaved: (val) {
                      print('pre guardar $val');
                      gAnimalData.name = val!;
                      print('post guardar $val');
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
                        print('antes de en save ${gAnimalData.name}');

                        _formKey.currentState!.save();
                        print('No en save ${gAnimalData.name}');

                        _isEnable = false;
                        _editIcon = Icons.edit;
                      }
                    } else {
                      print('No en save ${gAnimalData.name}');
                      _formKey.currentState!.save();
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

//Cell Field
class AnimalFormCell extends StatefulWidget {
  @override
  _AnimalFormCellState createState() => _AnimalFormCellState();
}

class _AnimalFormCellState extends State<AnimalFormCell> {
  bool _isEnable = false;
  IconData _editIcon = Icons.edit;
  double cellTextFieldSize = 20;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Text(
            'Cuadra',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            width: cellTextFieldSize,
            child: Form(
              key: _formKey,
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '-',
                ),
                onChanged: (text) {
                  setState(() {
                    cellTextFieldSize = 10;
                    text.length <= 3
                        ? cellTextFieldSize =
                            cellTextFieldSize + text.length * 7
                        : cellTextFieldSize = cellTextFieldSize + 3 * 7;
                  });
                },
                initialValue: gAnimalData.cell,
                enabled: _isEnable,
                onSaved: (val) {
                  val == '' ? gAnimalData.cell = '-' : gAnimalData.cell = val!;
                },
              ),
            )),
        Padding(
            padding: EdgeInsets.only(left: 0),
            child: IconButton(
                icon: Icon(_editIcon, size: 20),
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
                }))
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
                width: 120,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    initialValue: gAnimalData.breed,
                    enabled: _isEnable,
                    onSaved: (val) {
                      val == ''
                          ? gAnimalData.breed = '-'
                          : gAnimalData.breed = val!;
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
        width: 150.0,
        height: 150.0,
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
  DateTime entryDate;
  String entryDateStr;
  DateTime initialDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TextEditingController _controller = TextEditingController();

  _AnimalFormEntryDateState(this.entryDate)
      : entryDateStr = DateFormat("dd-MM-yyyy").format(entryDate);

  Future<DateTime?> _selectDate(BuildContext context) async {
    if (entryDate != DateTime.parse("1900-01-01")) {
      initialDate = entryDate;
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = entryDateStr;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha de llegada',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: TextFormField(
                controller: _controller,
                enabled: false,
                onSaved: (newValue) => _controller.text = entryDateStr,
              ),
            )),
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context).then((picked) {
                    if (picked != null && picked != initialDate)
                      setState(() {
                        entryDate = picked;
                        entryDateStr =
                            DateFormat("dd-MM-yyyy").format(entryDate);
                        _controller.text = entryDateStr;
                        gAnimalData.entryDate =
                            DateFormat("yyyy-MM-dd").format(entryDate);
                      });
                  });
                }),
            IconButton(
                icon: Icon(Icons.replay_outlined),
                onPressed: () {
                  setState(() {
                    entryDateStr =
                        new DateFormat('dd-MM-yyyy').format(DateTime.now());
                    _controller.text = entryDateStr;
                    gAnimalData.entryDate =
                        new DateFormat('yyyy-MM-dd').format(DateTime.now());
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
  _AnimalFormBirthDateState createState() =>
      _AnimalFormBirthDateState(this.birthDate);
}

class _AnimalFormBirthDateState extends State<AnimalFormBirthDate> {
  DateTime birthDate;
  String birthDateStr;
  DateTime initialDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TextEditingController _controller = TextEditingController();

  _AnimalFormBirthDateState(this.birthDate)
      : birthDateStr = DateFormat("dd-MM-yyyy").format(birthDate);

  Future<DateTime?> _selectDate(BuildContext context) async {
    if (birthDate != DateTime.parse("1900-01-01")) {
      initialDate = birthDate;
    }
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    if (birthDate == DateTime.parse("1900-01-01")) birthDateStr = '-';
    _controller.text = birthDateStr;
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
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: '-',
                ),
                enabled: false,
                onSaved: (newValue) => _controller.text = birthDateStr,
              ),
            )),
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context).then((picked) {
                    if (picked != null &&
                        picked != initialDate &&
                        picked.compareTo(DateTime.now()) < 0)
                      setState(() {
                        birthDate = picked;
                        var age = calculateAge(birthDate);
                        _ageController.text = '${age[0]} años, ${age[1]} meses';
                        birthDateStr =
                            DateFormat("dd-MM-yyyy").format(birthDate);
                        _controller.text = birthDateStr;
                        gAnimalData.birthDate =
                            DateFormat("yyyy-MM-dd").format(birthDate);
                      });
                  });
                }),
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  setState(() {
                    birthDateStr = '-';
                    _controller.text = birthDateStr;
                    gAnimalData.birthDate = "1900-01-01";
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
  bool _isEnable = false;
  @override
  Widget build(BuildContext context) {
    _ageController.text = widget.age;
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
                controller: _ageController,
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
                  val == ''
                      ? gAnimalData.description = '-'
                      : gAnimalData.description = val!;
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
                  val == ''
                      ? gAnimalData.diseases = '-'
                      : gAnimalData.diseases = val!;
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
                  val == ''
                      ? gAnimalData.entryReasons = '-'
                      : gAnimalData.entryReasons = val!;
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
                  val == ''
                      ? gAnimalData.notes = '-'
                      : gAnimalData.notes = val!;
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
