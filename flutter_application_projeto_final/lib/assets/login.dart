import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'telaPrincipal.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TraduApp',
      initialRoute: 't1',
      home: LoginPage(),
      routes: {
        't1': (context) => LoginPage(),
        't2': (context) => TelaPrincipal()
      },
    ),
  );
}

// ---------------------------- TELA DE LOGIN / USUARIO JÁ EXISTENTE ----------------------------------

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Para controlar se o usuário faz o login ou cadastro
enum FormType { login, register }

// Para enviar o nome do usuário para a tela Home
class Infos {
  String username;
  Infos(this.username);
}

class _LoginPageState extends State<LoginPage> {
  var username = TextEditingController();
  
  FormType _form = FormType.login;

  // Troca dos campos de login e registro
  void _formChange() async {
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
              margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
              child: Image.asset("images/translate.png")),
          SizedBox(height: 20),
          Text('TraduApp',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 20),
          makeInput(
              controllerword: username,
              label: "Nome de Usuário:",
              obsureText: false),
          makeInput(label: "Senha:", obsureText: true),
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
                onPressed: () {
                  setState(() {
                    var obj = Infos(
                      username.text,
                    );

                    Navigator.pushNamed(context, 't2', arguments: obj);

                    _loginPressed;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade800,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                )),
            // ------------------- FIM DBOTÃO LOGIN -------------------------------------
            SizedBox(height: 20),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                )),
            SizedBox(height: 20),
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

  void _loginPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TelaPrincipal()));
  }

  void _createAccountPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Register()));
  }

  void _passwordReset() {}
}

// ---------------------------- TELA DE SIGNUP / CADASTRO DE NOVO USUARIO ----------------------------------

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

enum Sexo { masculino, feminino }

class _RegisterState extends State<Register> {
  Sexo? _character = Sexo.masculino;
  var _checkbox = false;
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

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
                        SizedBox(height: 20),
                        Text(
                          "Cadastre-se!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Preencha os dados abaixo para criar uma conta:",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 20)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          makeInput(
                              controllerword: txtNome,
                              label: "Nome de Usuário:"),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Sexo:',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                )),
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
                          makeInput(
                            controllerword: txtEmail,
                            label: "E-mail:", 
                            obsureText: false
                          ),
                          makeInput(
                            controllerword: txtSenha,
                            label: "Senha:", 
                            obsureText: false
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _checkbox,
                                onChanged: (value) {
                                  setState(() {
                                    _checkbox = !_checkbox;
                                  });
                                },
                              ),
                              Text(
                                  'Concordo com os termos de uso deste aplicativo.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        child: ElevatedButton(
                            child: Text('Registrar'),
                            onPressed: () {
                              criarConta(
                                txtNome.text,
                                txtEmail.text,
                                txtSenha.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade800,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                            )),
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

  void _loginPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TelaPrincipal()));
  }

  void criarConta(nome, email, senha) {

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((value) {
            exibirMensagem('Usuário criado com sucesso!');
            Navigator.pop(context);
        }).catchError((erro){
          if (erro.code == 'email-already-in-use'){
            exibirMensagem('ERRO: O email informado está em uso.');
          }else if (erro.code == 'invalid-email'){
            exibirMensagem('ERRO: Email inválido.');
          }else{
            exibirMensagem('ERRO: ${erro.message}');
          }
        });

  }

  void exibirMensagem(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
// --------------------------------- Caixas de input -----------------------------------------------

Widget makeInput({controllerword, label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: controllerword,
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                // color: Colors.grey[400],
                ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  // color: Colors.grey[400]
                  )),
        ),
      ),
      SizedBox(
        height: 20,
      )
    ],
  );
}
