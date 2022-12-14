import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../global.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;
  bool estadoFlash = false;
  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    var camera = controller.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;

    // calculate scale depending on screen and camera ratios
    // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = size.aspectRatio * camera.aspectRatio;

    // to prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Transform.scale(
              scale: 1,
              child: Center(
                child: CameraPreview(controller),
              ),
            ),
            Padding(
              //alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (pictureFile != null)
                        Image.file(
                          File(pictureFile!.path),
                          scale: 30,
                        )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Global.colorTexto),
                          onPressed: () {
                            if (estadoFlash) {
                              controller.setFlashMode(FlashMode.off);
                              setState(() {
                                estadoFlash = false;
                              });
                            } else {
                              controller.setFlashMode(FlashMode.always);
                              setState(() {
                                estadoFlash = true;
                              });
                            }
                          },
                          child: Icon(
                            estadoFlash ? Icons.flash_on : Icons.flash_off,
                          )
                          //child: Text(estadoFlash ? 'Flash ON' : 'Flash OFF'),
                          ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            fixedSize: Size(70, 70),
                            backgroundColor: Global.colorSecundario),
                        onPressed: () async {
                          pictureFile = await controller.takePicture();
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.camera,
                          size: 30,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Global.colorTexto),
                        onPressed: () {
                          Navigator.pop(context, pictureFile!.path);
                        },
                        child: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // if (pictureFile != null)
            //   Image.file(
            //     File(pictureFile!.path),
            //     scale: 20,
            //   )
          ],
        ));
  }
}
