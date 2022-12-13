import 'package:flutter/material.dart';

import '../global.dart';

class wuakalaComentario extends StatefulWidget {
  final int index;
  const wuakalaComentario(this.index);

  @override
  State<wuakalaComentario> createState() =>
      _wuakalaComentarioState(index: this.index);
}

class _wuakalaComentarioState extends State<wuakalaComentario> {
  int index;
  Widget sizedBox = SizedBox(height: 20);

  _wuakalaComentarioState({required this.index});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Global.colorOficial,
          centerTitle: true,
          title: Text(
            "¡Comentar!",
          ),
        ),
        body: Container(
          child: Text("Comentariooooo"),
        ));
  }
}
