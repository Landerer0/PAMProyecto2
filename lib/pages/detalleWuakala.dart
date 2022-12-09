import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:proyecto02/dto/wuakalaDTO.dart';

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
      children: [
        Text("com id: " + com.id.toString()),
        Text("com autor: " + com.autor),
        Text("com descripcion: " + com.descripcion),
        Text("com comentario: " + com.fechaComentario),
        sizedBox,
      ],
    );
  }

  Widget mostrarDetalle(WuakalaDto wuakala) {
    List<Widget> listaComentarios = [];
    return Column(
      children: [
        Text("autor: " + wuakala.autor),
        sizedBox,
        Text("descripcion: " + wuakala.descripcion),
        sizedBox,
        Text("fecha: " + wuakala.fechaPublicacion),
        sizedBox,
        Text("sector: " + wuakala.sector),
        sizedBox,
        Text("url1: " + wuakala.urlFoto1),
        sizedBox,
        Text("url2: " + wuakala.urlFoto2),
        sizedBox,
        //! Agregar boton agregar comentario
        for (var comentario in wuakala.comentarios)
          mostrarComentario(comentario),
        sizedBox,
        Text("sigue ahi: " + wuakala.sigueAhi.toString()),
        sizedBox,
        Text("ya no esta: " + wuakala.yaNoEsta.toString()),
        sizedBox,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    futureWuakala = getDetalleWuakala();
    return Scaffold(
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
