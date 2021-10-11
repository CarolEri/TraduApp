import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ------------------ CONTAINER PRINCIPAL --------------------
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
          Text('Utilize os botões abaixo para navegar entre as telas. Se preferir, também pode utilizar os botões localizados na barra de navegação inferior da tela:',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.normal,
            )
          ),
        ],
      ),
    );
  }
}
