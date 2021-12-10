import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

Future<Map<String, dynamic>> readNFC() async {
  var availability = await FlutterNfcKit.nfcAvailability;
  Map<String, dynamic> result = {};
  if (availability != NFCAvailability.available) {
    sleep(Duration(seconds: 10));
    result = {'error': 'NFC no disponible o activado.'};
    return result;
  }
  try {
    await FlutterNfcKit.poll(timeout: Duration(seconds: 10));
    for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
      result = jsonDecode(utf8.decode(record.payload!).substring(2));
    }
  } on PlatformException catch (e) {
    result = {'error': 'No se ha detectado una tarjeta NFC a tiempo.'};
  }
  FlutterNfcKit.finish();
  return result;
}

Future<Map<String, dynamic>> writeNFC(Map<String, dynamic> animalData) async {
  var availability = await FlutterNfcKit.nfcAvailability;
  var tag;
  Map<String, dynamic> result = {};
  if (availability != NFCAvailability.available) {
    result = {'error': 'NFC no disponible o activado.'};
    return result;
  }

  try {
    tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 10));
    if (tag.ndefWritable!) {
      var data = ndef.TextRecord(language: ' ', text: json.encode(animalData));
      await FlutterNfcKit.writeNDEFRecords([data]);
      result = {'exito': 'Se ha escrito la tarjeta NFC correctamente.'};
    }
  } on PlatformException catch (e) {
    result = {'error': 'No se ha detectado una tarjeta NFC a tiempo.'};
    return result;
  }

  FlutterNfcKit.finish();
  return result;
}

class JsonAccess {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/animals.json');
  }

  Future<Map<String, dynamic>> readAnimalData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final Map<String, dynamic> data = await json.decode(contents);

      return data;
    } catch (e) {
      print('Error $e');
      return {};
    }
  }

  Future<File> writeAnimalData(Map<String, dynamic> animalData) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('${json.encode(animalData)}');
  }
}

List<int> calculateAge(DateTime birthDate) {
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
