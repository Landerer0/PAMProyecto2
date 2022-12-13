import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto02/pages/principal.dart';
import 'package:proyecto02/pages/cameraPage.dart';
import 'package:proyecto02/services/messageService.dart';

import '../global.dart';

class agregarMensaje extends StatefulWidget {
  const agregarMensaje({super.key});

  @override
  State<agregarMensaje> createState() => _agregarMensajeState();
}

class _agregarMensajeState extends State<agregarMensaje> {
  TextEditingController sectorController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  bool showPic = false;
  String? imagen1, imagen2;
  @override
  Future<void> validarMensaje(sector, descripcion, imagen1, imagen2) async {
    final response = await MessageService()
        .ingresoWuakala(Global.login, sector, descripcion, imagen1, imagen2);

    print(response.statusCode);

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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Principal()));
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

  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.colorOficial,
        centerTitle: true,
        title: Text(
          "¡Bienvenido ${Global.login}!",
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
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Global.colorSecundario),
                  ),
                ),
                sizedBox,
                TextField(
                    controller: sectorController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese un Sector",
                        labelText: "Sector",
                        suffixIcon: const Icon(Icons.format_quote,
                            color: Colors.black54))),
                sizedBox,
                TextField(
                    controller: descripcionController,
                    minLines: 10,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Ingrese una descripcion",
                        labelText: "Descripción",
                        suffixIcon: const Icon(Icons.forum))),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        if (imagen1 != null)
                          Image.file(
                            File(imagen1!),
                            scale: 30,
                          ),
                        sizedBox,
                        //Coso para capturar imagen de la camara
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Global.colorSecundario,
                                shape: const StadiumBorder()),
                            onPressed: () async {
                              _navigateAndDisplaySelection1(context);
                            },
                            child: const Text("Foto 1")),
                        sizedBox,
                        Text("Borrar"), // relacionado con la camara
                      ],
                    ),
                    Column(
                      children: [
                        if (imagen2 != null)
                          Image.file(
                            File(imagen2!),
                            scale: 30,
                          ),
                        sizedBox,
                        //Coso para capturar imagen de la camara
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Global.colorSecundario,
                                shape: const StadiumBorder()),
                            onPressed: () async {
                              _navigateAndDisplaySelection2(context);
                            },
                            child: const Text("Foto 2")),

                        //Coso para capturar imagen de la camara
                        sizedBox,
                        Text("Borrar"), // relacionado con la camara
                      ],
                    ),
                  ],
                ),
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Global.colorSecundario,
                            shape: const StadiumBorder()),
                        onPressed: () async {
                          if (sectorController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un título",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (descripcionController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un mensaje",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            File image1file =
                                File(imagen1!); //convert Path to File
                            Uint8List image1bytes = await image1file
                                .readAsBytes(); //convert to bytes
                            String base64string1 = base64.encode(
                                image1bytes); //convert bytes to base64 string
                            print(base64string1);
                            File image2file =
                                File(imagen2!); //convert Path to File
                            Uint8List image2bytes = await image2file
                                .readAsBytes(); //convert to bytes
                            String base64string2 = base64.encode(
                                image2bytes); //convert bytes to base64 string
                            print(base64string1);
                            print(base64string2);
                            if (base64string1 == base64string2)
                              print("iguales");
                            print(sectorController.text);
                            print(
                                "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
                            print(descripcionController.text);
                            validarMensaje(
                                sectorController.text,
                                descripcionController.text,
                                base64string1,
                                base64string2);
                          }
                        },
                        child: const Text("Denunciar Wuakala"))),
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Global.colorSecundario,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Principal()));
                        },
                        child: const Text("Me Arrepentí"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplaySelection1(BuildContext context) async {
    final result = await availableCameras().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraPage(cameras: value),
          ),
        ));

    setState(() {
      imagen1 = result;
    });

    if (!mounted) return;
  }

  Future<void> _navigateAndDisplaySelection2(BuildContext context) async {
    final result = await availableCameras().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraPage(cameras: value),
          ),
        ));

    setState(() {
      imagen2 = result;
    });

    if (!mounted) return;
  }
}
