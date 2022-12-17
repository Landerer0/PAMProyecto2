import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto02/pages/detalleWuakala.dart';
import 'package:proyecto02/services/messageService.dart';

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
  TextEditingController comentarioController = TextEditingController();

  _wuakalaComentarioState({required this.index});

  void enviarComentario() async {
    final response = await MessageService()
        .ingresoComentario(index, comentarioController.text);

    if (response.statusCode == 200) {
      // await es necesario para esperar a que el usuario presione el boton y alcance a leer el mensaje
      await CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.success,
        title: 'Felicitaciones',
        text: '¡Se ha registrado ingresado correctamente el mensaje!',
        loopAnimation: false,
      );
      // el usuario se registro correctamente
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => detalleWuakala(index),
        ),
      );
    } else {
      CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.error,
        title: 'Error al subir Wuakala...',
        text: 'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);

    return Scaffold(
        backgroundColor: Global.colorSupport,
        appBar: AppBar(
          backgroundColor: Global.colorOficial,
          centerTitle: true,
          title: Text(
            "¡Comentar!",
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Avisar por nuevo Wuakala",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Global.colorSecundario),
                    ),
                  ),
                  sizedBox,
                  TextField(
                      controller: comentarioController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          hintText: "Ingrese un Comentario",
                          labelText: "Comentario",
                          suffixIcon: const Icon(Icons.format_quote,
                              color: Colors.black54))),
                  sizedBox,
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Global.colorSecundario,
                              shape: const StadiumBorder()),
                          onPressed: () async {
                            if (comentarioController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Ingrese un título",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              enviarComentario();
                            }
                          },
                          child: const Text("Ingresar Comentario"))),
                  sizedBox,
                ],
              ),
            ),
          ),
        ));
  }
}
