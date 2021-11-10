import 'package:flutter/material.dart';

class AnimalFormDisplay extends StatelessWidget {
  final String id;

  AnimalFormDisplay(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${this.id}"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("${this.id}"),
        ));
  }
}
