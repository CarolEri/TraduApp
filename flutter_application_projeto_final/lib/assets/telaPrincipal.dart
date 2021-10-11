import 'package:flutter/material.dart';
import 'homePage.dart';
import 'aboutPage.dart';
import 'imageTranslator.dart';
import 'textTranslator.dart';
import 'vocabulary.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  //Índice da página que será carregada inicialmente
  var telaAtual = 0;
  
  //Controlador utilizado para troca das telas (páginas)
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var fixed;
    return Scaffold(
      //
      // BODY
      //
      body: PageView(
        controller: pageController,
        children: [
          HomePage(), // currentIndex = 0
          AboutPage(), // currentIndex = 1
          ImageTranslator(), // currentIndex = 2
          TextTranslator(), //currentIndex = 3
          VocabularyPage(), // currentIndex = 4 
        ],
        onPageChanged: (index) {
          setState(() {
            telaAtual = index;
          });
        },
      ),

      // ---------------------------------- NAVBAR --------------------------------
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text('Translator'),
        // ------------------- LINHA PARA RETIRAR BOTÃO DE 'VOLTAR' ----------------------
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Você tem novas mensagens!')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Show Snackbar',
            onPressed: () {
            },
          ),
        ]
      ),
      
      // ---------------------- BARRA DE NAVEGAÇÃO -----------------------------

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade800,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.40),

        selectedFontSize: 12,
        unselectedFontSize: 12,

        iconSize: 30,

        //Index do Botão Selecionado
        currentIndex: telaAtual,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Imagem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_rounded),
            label: 'Texto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Vocabulário',
          ),          
        ],

        // Mudança de Tela (Página)
        onTap: (index) {
          setState(() {
            telaAtual = index;
          });

          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
