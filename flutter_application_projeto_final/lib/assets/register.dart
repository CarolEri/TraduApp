import 'package:flutter/material.dart';
import 'telaPrincipal.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

enum Sexo { masculino, feminino }

class _RegisterState extends State<Register> {

  Sexo? _character = Sexo.masculino;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.brown.shade100,
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 30),
                        Text (
                          "Cadastre-se!", style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Preencha os dados abaixo para criar uma conta:",style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40
                      ),
                      child: Column(
                        children: <Widget>[
                          makeInput(label: "Nome de Usuário:"),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Sexo:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              )
                            ),
                          ),
                          ListTile(
                            title: const Text('Masculino'),
                            leading: Radio<Sexo>(
                              value: Sexo.masculino,
                              groupValue: _character,
                              onChanged: (Sexo? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Feminino'),
                            leading: Radio<Sexo>(
                              value: Sexo.feminino,
                              groupValue: _character,
                              onChanged: (Sexo? value) {
                                setState(() {
                                  _character = value;
                                });
                              },
                            ),
                          ),                             
                          makeInput(label: "Senha:",obsureText: true),
                          makeInput(label: "Confirme sua Senha:",obsureText: true),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(                        
                        child: ElevatedButton(
                          child: Text('Registrar'),
                          onPressed: _loginPressed,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade800,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _loginPressed () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TelaPrincipal()));
  }
  // void setState(Null Function() param0) {}
}

Widget makeInput({label,obsureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,style:
        TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
        ),
      ),
      SizedBox(height: 5,),
      TextField(
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Colors.grey[400],
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              // color: Colors.grey[400]
            )
          ),
        ),
      ),
      SizedBox(height: 30,)
    ],
  );
  
}