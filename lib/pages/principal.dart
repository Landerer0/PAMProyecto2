import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto02/pages/agregarWuakala.dart';
import 'package:proyecto02/pages/detalleWuakala.dart';
import 'package:proyecto02/pages/homeScreen.dart';
import 'package:proyecto02/dto/messageDTO.dart';
import 'package:proyecto02/pages/integrantes.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:http/http.dart' as http;

import '../dto/wuakalasDTO.dart';
import '../global.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  late Future<List<WuakalasDto>> futureMessages;
  late List items;

  @override
  void initState() {
    super.initState();
    futureMessages = getMessages();
  }

  Future<List<WuakalasDto>> getMessages() async {
    final response = await http.get(Uri.parse(Global.baseApiUrl + '/wuakalas'));

    print(response.statusCode);

    if (response.statusCode == 200) {
      //print(response.body);
      return wuakalasDtoFromJson(response.body);
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

  Future<void> validarMensajes() async {
    // buscar el nombre del usuario
    // print("Se esta Validando los datos");
    items = await futureMessages;
    return;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Global.colorSupport,
        appBar: AppBar(
          backgroundColor: Global.colorOficial,
          centerTitle: true,
          title: Text(
            "¡Bienvenido ${Global.login}!",
          ),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/yellow-drawer.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("¡Bienvenido ${Global.login}!",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white))
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color: Global.colorOficial,
              ),
              title: const Text("Agregar"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const agregarMensaje()));
              },
            ),
            ListTile(
              leading: Icon(Icons.people, color: Global.colorOficial),
              title: const Text("Integrantes"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Integrantes()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Global.colorOficial),
              title: const Text("Salir"),
              onTap: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
            )
          ],
        )),
        body: SingleChildScrollView(
          child: FutureBuilder<List<WuakalasDto>>(
              future: futureMessages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    List<Widget> listaMensajes = [];
                    for (var mensaje in snapshot.data!) {
                      listaMensajes.add(tarjeta(mensaje));
                    }
                    return Column(
                      children: listaMensajes,
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Text("Error al cargar los mensajes!");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const agregarMensaje()));
          },
          backgroundColor: Global.colorOficial,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget tarjeta(WuakalasDto obj) {
    const sizedBox = SizedBox(height: 20);
    return SingleChildScrollView(
      child: Padding(
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
                            title: Text(obj.sector,
                                style: TextStyle(
                                    color: Global.colorSecundario,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Por: ${obj.autor}",
                                    style:
                                        TextStyle(color: Global.colorOficial),
                                  ),
                                  Text(
                                    "Fecha: ${obj.fecha}",
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          detalleWuakala(obj.idWuakala)));
                            },
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      detalleWuakala(obj.idWuakala)));
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                        )),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
