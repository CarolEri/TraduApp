import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageTranslator extends StatefulWidget {
  @override
  _ImageTranslatorState createState() => _ImageTranslatorState();
}

class _ImageTranslatorState extends State<ImageTranslator> {
  /// Variables
  File? imageFile;
  var resultadoTraducao;

  static const Map<String, String> language = {
    "Inglês": "en",
    "Japonês": "jp",
    "Coreano": "kr",
  };

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.only(top:30, right: 30, bottom: 30, left: 30),
      color: Colors.brown.shade200,
      child: imageFile == null
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tradutor para Imagens',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Utilize os botões abaixo para selecionar uma imagem da sua Galeria ou tire uma nova imagem a partir da câmera do seu smartphone:',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              )
            ),
            SizedBox(height: 60),
            ElevatedButton(                                      
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              ),                    
              onPressed: () {
                _getFromGallery();
              },
              child: Text("Escolha uma imagem da Galeria"),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              ),
              onPressed: () {
                _getFromCamera();
              },
              child: Text("Tire uma foto com a Câmera"),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Selecione um idioma aqui: "),
                DropdownButton<String>(
                  //value: dropdownValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey.shade800),
                  underline: Container(
                    height: 2,
                    color: Colors.grey.shade800,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      // dropdownValue = newValue!;
                      // trans();
                    });
                  },
                  items: language
                      .map((string, value) {
                        return MapEntry(
                          string,
                          DropdownMenuItem<String>(
                            value: value,
                            child: Text(string),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Texto Traduzido:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text(
              resultadoTraducao == null ? "Nenhuma traução encontrada." : resultadoTraducao.toString(),
              style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 40),
          ],
        ),
      ): Container(
        child: Image.file(
          imageFile as File,
          fit: BoxFit.cover,
        ),
        )
    );
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ) as PickedFile;
    setState(() {
      imageFile = File(pickedFile.path);
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    ) as PickedFile;
    setState(() {
      imageFile = File(pickedFile.path);
    });
  }
}