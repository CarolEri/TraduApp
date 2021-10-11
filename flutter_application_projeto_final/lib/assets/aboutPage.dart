import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ------------------ CONTAINER PRINCIPAL --------------------
    return Container(
      padding: EdgeInsets.only(top:50, right: 30, bottom: 30, left: 30),
      color: Colors.brown.shade200,
      child: Column(
        children: [
            Text('Tema',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Tradução de idiomas estrangeiros para o português.',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              )
            ),
            SizedBox(height: 45),
            Text('Objetivo do Aplicativo',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Realizar a tradução de diversos idiomas através de um texto escrito ou do reconhecimento ótico de caracteres contidos em uma imagem.',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              )
            ),
            SizedBox(height: 45),
            Text('Desenvolvido por',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Caroline Eri Sato Ushirobira',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              )
            ),      
            SizedBox(height: 20),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'images/profile_photo.jpg',
                      width: 180.0,
                      height: 170.0,
                      fit: BoxFit.fill,
                  ),
              ),
        ],
      ),
    );
  }
}
