import 'package:flutter/material.dart';
import 'package:flutter_application_projeto_final/assets/aboutPage.dart';

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
   @override
 Widget build(BuildContext context) {
   return Container( 
      padding: EdgeInsets.only(top:50, right: 30, bottom: 30, left: 30),
      color: Colors.brown.shade200,      
      child: Column(          
          children: [
            Text('Olá',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Utilize os botões abaixo para navegar entre as telas do aplicativo. Se preferir, também pode utilizar os botões localizados na barra de navegação inferior:',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              )
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Sobre'),
              icon: Icon(Icons.info),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Tradutor de Imagens'),
              icon: Icon(Icons.photo),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Tradutor de Textos'),
              icon: Icon(Icons.border_color_outlined),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text('Lista de Vocabulário'),
              icon: Icon(Icons.list_alt),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
            ),
          ],               
      ),
   );
 }
}


