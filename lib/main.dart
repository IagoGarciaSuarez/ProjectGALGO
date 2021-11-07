import 'package:flutter/material.dart';

import './animal_list.dart';
import './animal_tile.dart';
import './animals.dart';

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
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GALGO",
      home: Scaffold(
        appBar: AppBar(
          title: Text("GALGO"),
          centerTitle: true,
        ),
        body: AnimalList(ANIMAL_LIST),
        /*Column(children: [
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, _) => Divider(),
                    controller: _controller,
                    physics: _physics,
                    itemCount: ANIMAL_LIST.length,
                    itemBuilder: (context, index) {
                      final item = ANIMAL_LIST[index];
                      return ListTile(
                        trailing: Icon(Icons.edit),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/${item['photo'].toString()}"),
                        ),
                        title: Text(item['name'].toString()),
                        subtitle: Text(item['id'].toString()),
                      );
                    })),
          ])*/
      ),
    );
  }
}
