import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Translator extends StatefulWidget {
  @override
  _TranslatorState createState() => _TranslatorState();
}

class _TranslatorState extends State<Translator> {
  /// Variables
  File? imageFile;

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Container(
        
            child: imageFile == null
                ? Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton( 
                                     
                      // color: Colors.greenAccent,
                    
                    onPressed: () {
                      _getFromGallery();
                    },
                    child: Text("Escolha uma imagem da Galeria"),
                  ),
                  Container(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    // color: Colors.lightGreenAccent,
                    onPressed: () {
                      _getFromCamera();
                    },
                    child: Text("Envie uma imagem da Câmera"),
                  )
                ],
              ),
            ): Container(
              child: Image.file(
                imageFile as File,
                fit: BoxFit.cover,
              ),
            ));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) as PickedFile;
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    ) as PickedFile;
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}