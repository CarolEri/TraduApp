import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class ImageTranslator extends StatefulWidget {
  @override
  _ImageTranslatorState createState() => _ImageTranslatorState();
}

class _ImageTranslatorState extends State<ImageTranslator> {
  
  Image? image;
  var resultadoTraducao;
  String _extractText = '';
  String _translatedText = '';

  // static const Map<String, String> language = {
  //   "Inglês": "en",
  //   "Japonês": "jp",
  //   "Coreano": "kr",
  // };

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 30),
        color: Colors.brown.shade100,
        child: image == null
            ? Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Tradutor para Imagens', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                    SizedBox(height: 60),
                    Text('Utilize o botão abaixo para selecionar uma imagem da sua Galeria que contenha um texto em inglês para tradução:', style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                    SizedBox(height: 60),
                    ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey.shade800),
                      onPressed: () {
                        _getFromGallery();
                      },
                      child: Text("Escolher uma imagem da Galeria"),
                    ),
                    SizedBox(height: 40)
                  ],
                ),
              )
            : Container(
                child: Column(children: [
                  Text('Imagem selecionada:', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Container(child: image, width: 300, height: 150),
                  SizedBox(height: 40),
                  Text('Texto extraído:', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text(_extractText, textAlign: TextAlign.center),
                  SizedBox(height: 40),
                  Text('Tradução:', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text(_translatedText, textAlign: TextAlign.center)
                ]),
              )
            );
  }

  /// Get from gallery
  _getFromGallery() async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    Image pickedImage;
    if (kIsWeb) {
      pickedImage = Image.network(pickedFile!.path);
    } else {
      pickedImage = Image.file(File(pickedFile!.path));
    }

    _extractText = await FlutterTesseractOcr.extractText(pickedFile.path,
        language: 'eng',
        args: {
          "psm": "4",
          "preserve_interword_spaces": "1",
        });

    final translator = GoogleTranslator();
    final input = _extractText;
    _translatedText =
        (await translator.translate(input, from: 'en', to: 'pt')).text;

    setState(() {
      image = pickedImage;
    });
  }
}
