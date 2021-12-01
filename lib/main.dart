import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

import './animal_list.dart';
import './animal_form.dart';
import './utils.dart';
import './animal.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //TURN OFF FOR PRESENTATION
      title: 'Project GALGO',
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  List<Animal> animalsDataList = [];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<Animal> animalsDataList = [];
  String? valueText;
  String? animalId;
  // TextEditingController _textFieldController = TextEditingController(
  // Future<void> _displayTextInputDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text('TextField in Dialog'),
  //           content: TextField(
  //             onChanged: (value) {
  //               setState(() {
  //                 valueText = value;
  //               });
  //             },
  //             controller: _textFieldController,
  //             decoration: InputDecoration(hintText: "Text Field in Dialog"),
  //             keyboardType: TextInputType.number,
  //           ),
  //           actions: <Widget>[
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(primary: Colors.red),
  //               child: Text('Cancelar'),
  //               onPressed: () {
  //                 setState(() {
  //                   Navigator.pop(context);
  //                 });
  //               },
  //             ),
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(primary: Colors.green),
  //               child: Text('OK'),
  //               onPressed: () {
  //                 setState(() {
  //                   animalId = valueText;
  //                   Navigator.pop(context);
  //                 });
  //                 SnackBar(
  //                   content: const Text('Acerce el teléfono a la tarjeta NFC'),
  //                   action: SnackBarAction(
  //                     label: 'Cerrar',
  //                     onPressed: () {
  //                       // Some code to undo the change.
  //                     },
  //                   ),
  //                 );
  //                 FlutterNfcReader.write("id", animalId).then((response) {
  //                   print(response.content);
  //                 });
  //               },
  //             ),
  //           ],
  //         );
  //       });
  //}

  // void readJson() async {
  //   final response = await rootBundle.loadString('assets/animals.json');
  //   late var data;
  //   this.setState(() {
  //     data = json.decode(response);
  //   });
  //   data.forEach((k, v) {
  //     animalsDataList.add(Animal.fromJson(k, v));
  //   });
  // }

  // @override
  // void initState() {
  //   this.readJson();
  // }
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/animals.json');
    final data = await json.decode(response);
    data.forEach((k, v) {
      animalsDataList.add(Animal.fromJson(k, v));
    });
    setState(() {});
  }

  void initState() {
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> nfc_result = {};
    return MaterialApp(
      title: "GALGO",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("GALGO"),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(Icons.nfc),
                onPressed: () {
                  ReadNFC().then((res) {
                    nfc_result = res;
                    if (nfc_result.containsKey('error')) {
                      print(nfc_result['error']);
                    }
                  });
                },
                // onPressed: () => FlutterNfcReader.read().then((response) {
                //   animalId = (response.content.substring(5));
                //   print(animalId);
                //   for (final element in ANIMAL_LIST) {
                //     if (element['id'].toString() == animalId) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => AnimalForm(element),
                //           ));
                //     }
                //     break;
                //   }
                //}),
              ),
            ),
          ],
        ),
        body: AnimalList(animalsDataList),
      ),
    );
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // void showInSnackBar(String value) {
  //   _scaffoldKey.currentState
  //       .showSnackBar(new SnackBar(content: new Text(value)));
  // }
}
