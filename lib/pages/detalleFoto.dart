import 'package:flutter/material.dart';

import '../global.dart';

class detalleFoto extends StatefulWidget {
  final String url;
  const detalleFoto(this.url);

  @override
  State<detalleFoto> createState() => _detalleFotoState(url: this.url);
}

class _detalleFotoState extends State<detalleFoto> {
  String url;
  _detalleFotoState({required this.url});
  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 20);
    return Scaffold(
      //const sizedBox = SizedBox(height: 20);
      appBar: AppBar(
        backgroundColor: Global.colorOficial,
        centerTitle: true,
        title: Text(
          "Detalle de foto wuakala",
        ),
      ),
      body: Center(
        child: Image.network(
          url,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
