import 'package:flutter/material.dart';

import './animal_list.dart';
import './animal_form.dart';
import './utils.dart';
import './animal.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true, //TURN OFF FOR PRESENTATION
      title: 'Project GALGO',
      home: _MyHomePage(jsonFile: JsonAccess()),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  //List<Animal> animalsDataList = [];

  const _MyHomePage({Key? key, required this.jsonFile}) : super(key: key);

  final JsonAccess jsonFile;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<Animal> animalsDataList = [];
  String? valueText;
  String? animalId;

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
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/animals.json');
  //   final Map<String, dynamic> data = await json.decode(response);
  //   final JsonAccess ja = new JsonAccess();
  //   ja.writeAnimalData(data);
  //   data.forEach((k, v) {
  //     animalsDataList.add(Animal.fromJson(k, v));
  //   });
  //   setState(() {});
  // Future<void> transferDB() async {
  //   final String response = await rootBundle.loadString('assets/animals.json');
  //   final Map<String, dynamic> data = await json.decode(response);
  //   widget.jsonFile.writeAnimalData(data);
  // }

  Future<void> loadAnimalData() async {
    var data = await widget.jsonFile.readAnimalData();
    data.forEach((k, v) {
      animalsDataList.add(Animal.fromJson(k, v));
    });
    setState(() {});
  }

  void initState() {
    loadAnimalData();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
      title: "GALGO",
      home: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalForm(Animal.empty()),
                ));
          },
        ),
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
                  final snackBar = SnackBar(
                    content: Text('Acerce el dispositivo a una tarjeta NFC',
                        style: TextStyle(fontSize: 15)),
                  );
                  if (_scaffoldKey.currentState != null) {
                    _scaffoldKey.currentState!.showSnackBar(snackBar);
                  }
                  readNFC().then((res) {
                    Animal animalRead =
                        Animal.fromJson(res.keys.first, res[res.keys.first]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimalForm(animalRead),
                        ));
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
