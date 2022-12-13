import 'dart:ffi';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto02/dto/wuakalaDTO.dart';
import 'package:proyecto02/pages/detalleFoto.dart';
import 'package:proyecto02/pages/wuakalaComentario.dart';

import '../dto/wuakalaDTO.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

import '../services/messageService.dart';

class detalleWuakala extends StatefulWidget {
  final int index;
  const detalleWuakala(this.index);

  @override
  State<detalleWuakala> createState() =>
      _detalleWuakalaState(index: this.index);
}

class _detalleWuakalaState extends State<detalleWuakala> {
  int index;
  late int textSigueAhi, textYaNoEsta;
  late Future<WuakalaDto> futureWuakala;
  Widget sizedBox = SizedBox(height: 20);

  _detalleWuakalaState({required this.index});

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  Widget mostrarComentario(Comentario com) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(2),
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          //leading: Icon(Icons.album),
                          title: Text(com.descripcion),
                          subtitle: Text("Por: " + com.autor),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget mostrarDetalle(WuakalaDto wuakala) {
    List<Widget> listaComentarios = [];
    textSigueAhi = wuakala.sigueAhi;
    textYaNoEsta = wuakala.yaNoEsta;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            wuakala.sector,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          sizedBox,
          Text(
            wuakala.descripcion,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          sizedBox,
          //Text("url1: " + wuakala.urlFoto1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Image.network(
                    Global.baseApiUrl + "/images/" + wuakala.urlFoto1,
                    scale: 10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => detalleFoto(Global.baseApiUrl +
                              "/images/" +
                              wuakala.urlFoto1)));
                },
              ),
              SizedBox(
                width: 30,
              ),
              if (wuakala.urlFoto2 == "") ...[
                InkWell(
                  child: Image.network(
                      Global.baseApiUrl + "/images/" + wuakala.urlFoto2,
                      scale: 10),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => detalleFoto(
                                Global.baseApiUrl +
                                    "/images/" +
                                    wuakala.urlFoto2)));
                  },
                ),
              ],
              Image.network(Global.baseApiUrl + "/images/" + wuakala.urlFoto2,
                  scale: 10),
            ],
          ),
          sizedBox,
          Text("Subido por: " +
              wuakala.autor +
              " el día " +
              wuakala.fechaPublicacion),

          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Global.colorSecundario,
                      shape: const StadiumBorder()),
                  onPressed: () async {
                    final response = await MessageService()
                        .sigueAhiWuakala(index.toString());
                    print(response.statusCode);
                    if (response.statusCode == 200) {
                      Fluttertoast.showToast(
                          msg: "Se ingreso valor correctamente",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      setState(() {
                        textSigueAhi += 1;
                      });
                    } else {
                      CoolAlert.show(
                        backgroundColor: Global.colorSupport,
                        confirmBtnColor: Global.colorSecundario,
                        context: context,
                        type: CoolAlertType.error,
                        title: 'Error al subir Sigue Ahi...',
                        text:
                            'Ha ocurrido un error, vuelve a intentarlo más tarde',
                        loopAnimation: false,
                      );
                    }
                  },
                  child: Text("Sigue ahí (" + textSigueAhi.toString() + ")")),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Global.colorSecundario,
                      shape: const StadiumBorder()),
                  onPressed: () async {
                    final response = await MessageService()
                        .yaNoEstaWuakala(index.toString());

                    if (response.statusCode == 200) {
                      Fluttertoast.showToast(
                          msg: "Se ingreso valor correctamente",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      setState(() {
                        textYaNoEsta += 1;
                      });
                    } else {
                      CoolAlert.show(
                        backgroundColor: Global.colorSupport,
                        confirmBtnColor: Global.colorSecundario,
                        context: context,
                        type: CoolAlertType.error,
                        title: 'Error al subir Ya No está...',
                        text:
                            'Ha ocurrido un error, vuelve a intentarlo más tarde',
                        loopAnimation: false,
                      );
                    }
                  },
                  child: Text("Ya no está (" + textYaNoEsta.toString() + ")")),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Comentarios",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Global.colorSecundario,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      wuakalaComentario(index)));
                        },
                        child: Text("Comentar"))
                  ],
                ),
                for (var comentario in wuakala.comentarios)
                  mostrarComentario(comentario),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    futureWuakala = getDetalleWuakala();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 70, 70, 70)
          ])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Global.colorOficial,
          centerTitle: true,
          title: Text(
            "Detalle de wuakala: " + this.index.toString() + "!",
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<WuakalaDto>(
              future: futureWuakala,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return mostrarDetalle(snapshot.data!);
                  }
                } else if (snapshot.hasError) {
                  return const Text("Error al cargar los mensajes!");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  Future<WuakalaDto> getDetalleWuakala() async {
    print(this.index);
    final response = await MessageService().getWuakala(this.index);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);
      return wuakalaDtoFromJson(response.body);
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text: 'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
      throw Exception('Error GET api mensajes');
    }
  }
}
