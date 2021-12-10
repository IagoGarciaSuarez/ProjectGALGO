import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Animal {
  String id,
      name,
      cell,
      breed,
      photo,
      chip,
      birthDate,
      entryDate,
      description,
      diseases,
      entryReasons,
      notes;

  Animal(
      {required this.id,
      required this.cell,
      required this.name,
      required this.breed,
      required this.photo,
      required this.chip,
      required this.birthDate,
      required this.entryDate,
      required this.description,
      required this.diseases,
      required this.entryReasons,
      required this.notes});

  factory Animal.fromJson(String id, Map<String, dynamic> jsonData) {
    return Animal(
        id: id,
        name: jsonData['name'] as String,
        cell: jsonData['cell'] as String,
        breed: jsonData['breed'] as String,
        photo: jsonData['photo'] as String,
        chip: jsonData['chip'] as String,
        birthDate: jsonData['birthDate'] as String,
        entryDate: jsonData['entryDate'] as String,
        description: jsonData['description'] as String,
        diseases: jsonData['diseases'] as String,
        entryReasons: jsonData['entryReasons'] as String,
        notes: jsonData['notes'] as String);
  }

  factory Animal.empty() {
    return Animal(
        id: Uuid().v4(),
        cell: '-',
        name: '',
        breed: '',
        photo: 'galgo.png',
        chip: '-',
        birthDate: '-',
        entryDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
        description: '-',
        diseases: '-',
        entryReasons: '-',
        notes: '-');
  }

  Map<String, dynamic> toJson() => {
        this.id: {
          "name": this.name,
          "cell": this.cell,
          "breed": this.breed,
          "photo": this.photo,
          "chip": this.chip,
          "birthDate": this.birthDate,
          "entryDate": this.entryDate,
          "description": this.description,
          "diseases": this.diseases,
          "entryReasons": this.entryReasons,
          "notes": this.notes
        }
      };

  Animal cloneAnimal() {
    return Animal(
        id: id,
        name: name,
        cell: cell,
        breed: breed,
        photo: photo,
        chip: chip,
        birthDate: birthDate,
        entryDate: entryDate,
        description: description,
        diseases: diseases,
        entryReasons: entryReasons,
        notes: notes);
  }
}
