import 'package:flutter/material.dart';
// import 'login.dart';

class HomePage extends StatelessWidget {
  
  
   @override
 Widget build(BuildContext context) {

  //  final Infos obj = ModalRoute.of(context)!.settings.arguments as Infos;

   return Container( 
      padding: EdgeInsets.only(top:50, right: 30, bottom: 30, left: 30),
      color: Colors.brown.shade100,      
      child: Column(          
          children: [
            Text('Olá, ', 
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height: 20),
            Text('Seja bem-vindo(a) ao TraduApp! Utilize os botões localizados na barra de navegação inferior do aplicativo para acessar as seguintes telas:',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.justify
            ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.info, size: 18),
                  ),
                  TextSpan(
                    text: " Tela 'Sobre': Conheça mais sobre o TraduApp e sobre a desenvolvedora.",
                    style: TextStyle(color: Colors.black, fontSize: 18)
                  )
                ],
              ),
            ),            
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.photo, size: 18),
                  ),
                  TextSpan(
                    text: " Tela 'Tradução de Imagem': Traduza textos do inglês, japonês ou coreano para o português através do reconhecimento ótico de caracteres contidos em uma imagem.",
                    style: TextStyle(color: Colors.black, fontSize: 18)
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.border_color_outlined, size: 18),
                  ),
                  TextSpan(
                    text: " Tela 'Tradução de Texto': Digite palavras em inglês, japonês ou coreano e traduza para o português.",
                    style: TextStyle(color: Colors.black, fontSize: 18)
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.list_alt, size: 18),
                  ),
                  TextSpan(
                    text: " Tela 'Vocabulário': Utilize este espaço para aprender e memorizar novas palavras!",
                    style: TextStyle(color: Colors.black, fontSize: 18)
                  )
                ],
              ),
            ),
          ],               
      ),
   );
 }
}


