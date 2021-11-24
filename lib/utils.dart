import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;

Future<Map<String, dynamic>> ReadNFC() async {
  var availability = await FlutterNfcKit.nfcAvailability;
  Map<String, dynamic> result = {};
  if (availability != NFCAvailability.available) {
    result = {'error': 'NFC no disponible o activado.'};
    return result;
  }
  try {
    await FlutterNfcKit.poll(timeout: Duration(seconds: 10));
  } on PlatformException catch (e) {
    result = {'error': 'No se ha detectado una tarjeta NFC a tiempo.'};
  }
  for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
    result = jsonDecode(utf8.decode(record.payload!).substring(2));
  }
  return result;
}

Future<Map<String, dynamic>> WriteNFC(Map<String, String> animalData) async {
  var availability = await FlutterNfcKit.nfcAvailability;
  var tag;
  Map<String, dynamic> result = {};
  if (availability != NFCAvailability.available) {
    result = {'error': 'NFC no disponible o activado.'};
    return result;
  }

  try {
    tag = await FlutterNfcKit.poll(timeout: Duration(seconds: 1));
    if (tag.ndefWritable!) {
      var data = ndef.TextRecord(language: ' ', text: json.encode(animalData));
      await FlutterNfcKit.writeNDEFRecords([data]);
      result = {'exito': 'Se ha escrito la tarjeta NFC correctamente.'};
    }
  } on PlatformException catch (e) {
    result = {'error': 'No se ha detectado una tarjeta NFC a tiempo.'};
    print(result);
    return result;
  }

  FlutterNfcKit.finish();
  return result;
}
