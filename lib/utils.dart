// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:ndef/ndef.dart' as ndef;

// Future<String> ReadNFC() async {
//   var availability = await FlutterNfcKit.nfcAvailability;
//   if (availability != NFCAvailability.available) {
//     print('No nfc available');
//   }
//   return '1234fasdafd';
// }

Future<String> WriteNFC() async {
  var ret = 'Escribir a NFC';
  print(ret);
  return ret;
}
