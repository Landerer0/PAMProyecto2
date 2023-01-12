// ignore_for_file: use_build_context_synchronously

import 'package:cool_alert/cool_alert.dart';
import 'package:proyecto02/global.dart';
import 'package:proyecto02/pages/principal.dart';
import 'package:proyecto02/services/loginService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dto/userDTO.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  late final pref;
  late Future<UserDto> futureUser;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> validarDatos(String user, String password) async {
    print("Validar 1");
    print(user + " " + password);
    final response = await LoginService().validar(user, password);

    print("Validar 2");

    //print("response:");
    print(response.statusCode);
    if (response.statusCode == 200) {
      //almacenar de alguna manera el login

      await pref.setString('email', user);
      UserDto usuario = userDtoFromJson(response.body);

      Global.login = usuario.email!;
      Global.idUsuario = usuario.idUsuario!;
      //print(Global.idUsuario);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Principal()));
    } else if (response.statusCode == 404) {
      CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text:
            "Datos Incorrectos", //'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
    } else {
      CoolAlert.show(
        backgroundColor: Global.colorSupport,
        confirmBtnColor: Global.colorSecundario,
        context: context,
        type: CoolAlertType.error,
        title: 'Oops...',
        text:
            "Error API", //'Ha ocurrido un error, vuelve a intentarlo más tarde',
        loopAnimation: false,
      );
    }
  }

  String? login_guardado = "";

  @override
  void initState() {
    super.initState();
    cargaPreferencia();
  }

  void cargaPreferencia() async {
    pref = await SharedPreferences.getInstance();
    login_guardado = pref.getString("email");
    emailController.text = login_guardado == null ? "" : login_guardado!;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      backgroundColor: Global.colorSupport,
      appBar: AppBar(
        backgroundColor: Global.colorOficial,
        title: const Text("Ingreso"),
        centerTitle: true,
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
                    "Ingresa tus credenciales",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Global.colorSecundario),
                  ),
                ),
                Image.asset("assets/images/newLogin.png"),
                sizedBox,
                TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese su email",
                        labelText: "Email",
                        suffixIcon:
                            const Icon(Icons.email, color: Colors.black54))),
                sizedBox,
                TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        hintText: "Ingrese su contraseña",
                        labelText: "Contraseña",
                        suffixIcon: const Icon(Icons.remove_red_eye))),
                sizedBox,
                sizedBox,
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Global.colorSecundario,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          ////DEMOOOOOO
                          //Global.login = "DEMO";
                          //Navigator.push(
                          //    context,
                          //    MaterialPageRoute(
                          //        builder: (context) => Principal()));
                          ////DEMO LOGIN
                          //return;

                          if (emailController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un email válido",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (!emailController.text.contains('@')) {
                            Fluttertoast.showToast(
                                msg: "Ingrese un email válido (@)",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (passwordController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Ingrese una contraseña",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            validarDatos(
                                emailController.text, passwordController.text);
                          }
                        },
                        child: const Text("Acceder"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
