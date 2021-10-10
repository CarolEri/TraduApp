import 'package:flutter/material.dart';
import 'telaPrincipal.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Para controlar se o usuário faz o login ou cadastro
enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
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
    return new Scaffold(
      body: new Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.brown.shade100,
                Colors.white,
              ],
            )
          ),
        padding: EdgeInsets.all(50.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(left:0, top:0, right:0, bottom:0),
            child: new Image.asset("images/sakura_tree.png")
          ),
          new Container(
            child: new TextField(
              onChanged: (nomeUsuario){
                _username = nomeUsuario;
                print(_username);
              },
              controller: _usernameFilter,
              decoration: new InputDecoration(
                labelText: 'Nome de Usuário:'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              onChanged: (senhaUsuario){
                _password = senhaUsuario;
              },
              controller: _passwordFilter,
              decoration: new InputDecoration(
                labelText: 'Senha:'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 45),
        child: new Column(
          children: <Widget>[
            new ElevatedButton(
              child: new Text('Login'),
              onPressed: _loginPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              )
            ),
            SizedBox(height: 40),
            new TextButton(
              child: new Text('Não possui conta? Clique aqui para se cadastrar.'),
              onPressed: _formChange,
            ),
            SizedBox(height: 15),
            new TextButton(
              child: new Text('Esqueceu sua senha?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return new Container(
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 45),
        child: new Column(
          children: <Widget>[
            new ElevatedButton(
              child: new Text('Crie uma conta!'),
              onPressed: _createAccountPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
              )
            ),
            SizedBox(height: 40),
            new TextButton(
              child: new Text('Já possui conta? Clique aqui para fazer o login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  // --------- Abaixo, vou implementar futuramente as lógicas para cada situação ----------------------

  void _loginPressed () {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TelaPrincipal()));
  }

  void _createAccountPressed () {
    
  }

  void _passwordReset () {
    
  }


}