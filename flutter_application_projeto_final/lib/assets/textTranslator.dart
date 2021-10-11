import 'package:flutter/material.dart';

class TextTranslator extends StatefulWidget {
  @override
  _TextTranslatorState createState() => _TextTranslatorState();
}
class _TextTranslatorState extends State<TextTranslator> {
  /// Variables
  
  
  /// Widget
  @override
  Widget build(BuildContext context) {
    return Container(
      
        padding: EdgeInsets.all(30),
        color: Colors.brown.shade200,  
        child: Text('Tradutor Textos',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            )
          ),
        
      
    );
  }

}