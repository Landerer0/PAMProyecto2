import 'package:flutter/material.dart';
import 'package:proyecto02/pages/login.dart';

import '../global.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 30);
    return Scaffold(
      //backgroundColor: Color.fromRGBO(62, 127, 139, 1),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Global.colorOficial, Global.colorSupport],
        )),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sizedBox,
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Wakala APP",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Global.colorSecundario),
                  ),
                ),
                sizedBox,
                Image.asset("assets/images/welcome2.png"),
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
                                  builder: (context) => const login()));
                        },
                        child: const Text("Ingresar"))),
                sizedBox,
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("by",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.italic)),
                      SizedBox(
                        width: 60,
                      ),
                      Column(
                        children: [
                          Text(
                            "Lucas Kraemer",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("Cristián Pérez", style: TextStyle(fontSize: 20))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
