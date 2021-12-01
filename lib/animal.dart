class Animal {
  String id,
      name,
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

  Map<String, dynamic> toJson() => {
        this.id: {
          "name": this.name,
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
