import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {

  var lista = [];
  var palavraEstrangeira = TextEditingController();
  var significado = TextEditingController();

  // --------------- RETORNAR um ÚNICO DOCUMENTO a partir do ID ---------------
  
  getDocumentById(id) async{
    await FirebaseFirestore.instance.collection('vocabulario')
      .doc(id).get().then((doc) {
        palavraEstrangeira.text = doc.get('palavra');
        significado.text = doc.get('significado');
      });
  }

  @override
  void initState() {    
    lista.add("春: Primavera");
    lista.add("犬: Cachorro");
    lista.add("料理: Comida");
    lista.add("願い: Desejo");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var id = ModalRoute.of(context)?.settings.arguments;

    if (id != null){
      if (palavraEstrangeira.text.isEmpty && significado.text.isEmpty){
        getDocumentById(id);
      }
    }
    
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.brown.shade100,
        // ---------------- ListView ------------------------------------------------
        
        child: ListView.builder(
          //quantidade de elementos da lista
          itemCount: lista.length,

          itemBuilder: (context, index) {

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              color: Colors.grey.shade100,

              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(

                title: Text(
                  lista[index],
                  style: TextStyle(fontSize: 20),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('Tem certeza que deseja remover esta palavra?'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () { 
                                //remover um item da lista
                                Navigator.pop(context);
                                setState(() {
                                  lista.removeAt(index);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Palavra removida com sucesso!'),
                                    duration: Duration(seconds: 2),
                                  ));
                                }); 
                              },
                              child: const Text('Sim'),                              
                            ),
                            SimpleDialogOption(
                              onPressed: () { Navigator.pop(context); },
                              child: const Text('Não'),
                            ),
                          ],
                        );
                      }
                    );
                  }                  
                ),
              ),
            );
          },
        ),
      ),

      // ----------------- Adicionar novas tarefas -----------------------------      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        child: Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(

                title: Text(
                  'Adicione uma nova palavra:',
                  style: TextStyle(fontSize: 16),
                ),
                content: SingleChildScrollView( 
                  child: ListBody(
                    children: [
                      
                      TextField(
                        controller: palavraEstrangeira,
                        style: TextStyle(fontSize: 14), 
                        decoration: InputDecoration(                            
                          hintText: 'Insira aqui a palavra estrangeira'
                        ),                   
                      ),
                      TextField(
                        controller: significado,
                        style: TextStyle(fontSize: 14),   
                        decoration: InputDecoration(                            
                          hintText: 'Insira aqui o significado'
                        ),                      
                      )
                    ]
                  )                    
                ),
                
                actions: [
                  TextButton(
                    child: Text('ok'),
                    onPressed: () {

                        if (id == null){                            
                          // --------------- ADICIONAR um NOVO DOCUMENTO ---------------                            
                          FirebaseFirestore.instance.collection('vocabulario').add({
                            'palavra': palavraEstrangeira.text,
                            'significado': significado.text,
                          });
                          addVocabulary();
                        }
                        else {                          
                          // --------------- ATUALIZAR UM DOCUMENTO EXISTENTE ---------------                            
                          FirebaseFirestore.instance.collection('vocabulario').doc(id.toString()).set({
                            'palavra': palavraEstrangeira.text,
                            'significado': significado.text,
                          });
                          addVocabulary();
                        } 
                    },
                  ),
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
        },
      ),
    );
  }

  void addVocabulary(){
    
    var msg = '';
    if (palavraEstrangeira.text.isNotEmpty && significado.text.isNotEmpty) {
      lista.add(palavraEstrangeira.text + ': ' + significado.text);
      palavraEstrangeira.clear();
      significado.clear();
      msg = 'Palavra adicionada com sucesso!';
    }
    else {
      msg = 'Nenhuma palavra foi adicionada.';
    } 

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }
}
