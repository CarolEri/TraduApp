import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'pages/telaPrincipal.dart';

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
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;  
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
              controllerword: txtEmail,
              label: "E-mail:",
              obsureText: false
          ),
          makeInput(
              controllerword: txtSenha,
              label: "Senha:", 
              obsureText: true
          ),
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
                    isLoading = true;                
                  });
                  login(txtEmail.text, txtSenha.text);
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

  void _createAccountPressed() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Register()));
  }

  void _passwordReset() {}

  void login(email, senha) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TelaPrincipal()));
      // FirebaseAuth.instance
      //     .signInWithEmailAndPassword(email: email, password: senha)
      //     .then((value) {
      //   Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => TelaPrincipal()));
      // }).catchError((erro) {
      //   if (erro.code == 'user-not-found') {
      //     exibirMensagem('ERRO: Usuário não encontrado.');
      //   } else if (erro.code == 'wrong-password') {
      //     exibirMensagem('ERRO: Senha incorreta.');
      //   } else if (erro.code == 'invalid-email') {
      //     exibirMensagem('ERRO: Email inválido.');
      //   } else {
      //     exibirMensagem('ERRO: ${erro.message}.');
      //   }
      // });
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

// ---------------------------- TELA DE SIGNUP / CADASTRO DE NOVO USUARIO ----------------------------------

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

enum Sexo { masculino, feminino }

class _RegisterState extends State<Register> {
  late CollectionReference usuarios;
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtCPF = TextEditingController();
  var txtTelefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Container(     
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [                  
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
            SizedBox(height: 20),
            makeInput(
              controllerword: txtNome,
              label: "Nome de Usuário:"
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
            makeInput(
              controllerword: txtCPF,
              label: "CPF:", 
              obsureText: false
            ),
            makeInput(
              controllerword: txtTelefone,
              label: "Telefone:", 
              obsureText: false
            ),
            ElevatedButton(
              child: Text('Registrar'),
              onPressed: () {
                criarConta(
                  txtNome.text,
                  txtEmail.text,
                  txtSenha.text,
                  txtCPF.text,
                  txtTelefone.text,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade800,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20),
              )
            ),
          ]
        ),
      ),   
    );
  }
  

  void criarConta(nome, email, senha, cpf, telefone) {

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
    FirebaseFirestore.instance.collection('usuarios').add({
        'nome': txtNome.text,
        'CPF': txtCPF.text,
        'telefone': txtTelefone.text,
        'email': txtEmail.text,
        'senha': txtSenha.text
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
