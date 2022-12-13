import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto02/dto/wuakalaDTO.dart';
import 'package:proyecto02/pages/wuakalaComentario.dart';

import '../dto/wuakalaDTO.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

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
  late Future<WuakalaDto> futureWuakala;
  Widget sizedBox = SizedBox(height: 20);

  _detalleWuakalaState({required this.index});

  Widget mostrarComentario(Comentario com) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          com.descripcion,
          style: TextStyle(fontSize: 16),
        ),
        sizedBox,
        Text(
          "Por: " + com.autor,
          textAlign: TextAlign.end,
        ),
        //Text("com id: " + com.id.toString()),
        //Text("com autor: " + com.autor),
        //Text("com descripcion: " + com.descripcion),
        //Text("com comentario: " + com.fechaComentario),
        sizedBox,
        sizedBox,
      ],
    );
  }

  Widget mostrarDetalle(WuakalaDto wuakala) {
    List<Widget> listaComentarios = [];
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
          Text("url1: " + wuakala.urlFoto1),
          sizedBox,
          Text("url2: " + wuakala.urlFoto2),
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
                      //! Aumentar valor de sigue ahi, mismo para ya no esta
                      Fluttertoast.showToast(
                          msg: "Se ingreso valor correctamente",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
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
                  child:
                      Text("Sigue ahí (" + wuakala.sigueAhi.toString() + ")")),
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
                  child:
                      Text("Ya no está (" + wuakala.yaNoEsta.toString() + ")")),
            ],
          ),
          //! Agregar boton agregar comentario
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
