import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TextTranslator extends StatefulWidget {
  @override
  _TextTranslatorState createState() => _TextTranslatorState();
}

class _TextTranslatorState extends State<TextTranslator> {

  late CollectionReference historico;
  var txtToTranslate = TextEditingController();
  GoogleTranslator translator = GoogleTranslator();
  var txtTranslated;
  //String dropdownValue;

  static const Map<String, String> language = {
    "Inglês": "en",
    "Japonês": "jp",
    "Coreano": "kr",
  };

  // void trans() {
  //   translator
  //       .translate(textEditingController.text, to: "$dropdownValue")
  //       .then((value) {
  //     setState(() {
  //       resultadoTraducao = value;
  //     });
  //   });
  // }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.only(top:30, right: 30, bottom: 30, left: 30),
      color: Colors.brown.shade100,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tradutor de Texto',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Utilize o campo abaixo para escrever o texto que deseja traduzir:',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              )
            ),
            SizedBox(height: 40),
            TextFormField(
                style: TextStyle(fontSize: 24),
                controller: txtToTranslate,
                decoration: InputDecoration(
                    labelText: 'Digite aqui',
                    labelStyle: TextStyle(fontSize: 15)
                ),
              ),            
            SizedBox(height: 20),
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
            ElevatedButton(                                      
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              ),                    
              onPressed: () {     
                FirebaseFirestore.instance.collection('historico').add({
                  'textoParaTraduzir': txtToTranslate.text,
                  // 'textoTrauzido': txtTranslated.text
                });                       
              },
              child: Text("Traduzir"),
            ),
            SizedBox(height: 40),
            Text('Texto Traduzido:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),            
            Container(
              height: 130,
              width: double.infinity,
              child: Card(              
                color: Colors.grey.shade100,
                shadowColor: Colors.black,
                elevation: 20,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                txtTranslated == null ? "Nenhuma tradução encontrada." : txtTranslated.toString(),
                style: TextStyle( fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center
              ),
              )
            ),
          ],
        ),
      ),
    );
  }

}