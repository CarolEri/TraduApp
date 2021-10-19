import 'package:flutter/material.dart';
import 'homePage.dart';
import 'telaPrincipal.dart';
import 'register.dart';

void main() {
  runApp(    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator',
      initialRoute: 't1',
      routes: {
        't1': (context) => LoginPage(),
        't2': (context) => TelaPrincipal()
      },
    ),
  );
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Para controlar se o usuário faz o login ou cadastro
enum FormType {
  login,
  register
}

// Para enviar o nome do usuário para a tela Home
class Infos{
  final String username;
  Infos(this.username);
}

class _LoginPageState extends State<LoginPage> {

  var username = TextEditingController();
  final TextEditingController _usernameFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _username = "";
  String _password = "";
  FormType _form = FormType.login; 

  _LoginPageState() {
    _usernameFilter.addListener(_usernameListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _usernameListen() {
    if (_usernameFilter.text.isEmpty) {
      _username = "";
    } else {
      _username = _usernameFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Troca dos campos de login e registro
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
           color: Colors.brown.shade100,
        ),
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left:0, top:0, right:0, bottom:0),
            child: Image.asset("images/translate.png")
          ),
          SizedBox(height: 20),
          makeInput(controllerword: username, label: "Nome de Usuário:",obsureText: false),
          makeInput(label: "Senha:",obsureText: true),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          children: <Widget>[

            // ------------------- BOTÃO LOGIN -------------------------------------
            ElevatedButton(
              child: Text('Login'),
              onPressed: (){
                setState(() {

                    var obj = Infos(
                      username.text, 
                    );

                    Navigator.pushNamed(
                      context, 
                      't2',
                      arguments: obj
                    );
                    
                    _loginPressed; 
                  });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              )
            ),
            // ------------------- FIM DBOTÃO LOGIN -------------------------------------
            SizedBox(height: 40),
            TextButton(
              child: Text('Não possui conta? Clique aqui para se cadastrar.'),
              onPressed: _formChange,
            ),
            SizedBox(height: 15),
            TextButton(
              child: Text('Esqueceu sua senha?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('Crie uma conta!'),
              onPressed: _createAccountPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              )
            ),
            SizedBox(height: 40),
            TextButton(
              child: Text('Já possui conta? Clique aqui para fazer o login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // --------- -------------------------------- ----------------------

  void _loginPressed () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TelaPrincipal()));
  }

  void _createAccountPressed () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register()));
  }

  void _passwordReset () {
    
  }
}

// ---------- Caixas de input -----------------------------------------------

Widget makeInput({controllerword, label,obsureText = false}){
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
        controller: controllerword,
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