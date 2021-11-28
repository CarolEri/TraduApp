import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  late CollectionReference vocabulario;
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
    super.initState();
    vocabulario = FirebaseFirestore.instance.collection('vocabulario');
  }

  exibirItemColecao(item){

    String palavra = item.data()['palavra'];
    String significado = item.data()['significado'];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: Colors.grey.shade100,

      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child:  ListTile(
        title: Text(palavra + ': ' + significado, style: const TextStyle(fontSize: 20),),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: (){            
            // APAGAR um documento          
            vocabulario.doc(item.id).delete();
          },
        ),

        onTap: (){
          Navigator.pushNamed(context, '/cadastro', arguments: item.id);
        },
      )
    );
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
      backgroundColor: Colors.brown.shade100,
      body: StreamBuilder<QuerySnapshot>(
        
        //fonte de dados (coleção)
        stream: vocabulario.snapshots(),

        //exibir os dados retornados
        builder: (context, snapshot){

          //verificar o estado da conexão
          switch(snapshot.connectionState){

            case ConnectionState.none:
              return const Center(child: Text('Não foi possível conectar ao Firestore'),);

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator(),);

            //se os dados foram recebidos com sucesso
            default:
              final dados = snapshot.requireData;
              return ListView.builder(
                itemCount: dados.size,
                itemBuilder: (context, index){
                  return exibirItemColecao(dados.docs[index]);
                }
              );
          }
        }
      ),

      // ----------------- Adicionar novos cards -----------------------------      
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
