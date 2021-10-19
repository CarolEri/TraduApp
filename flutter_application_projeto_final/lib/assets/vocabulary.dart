import 'package:flutter/material.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  //lista dinâmica para armazenamento das palavras
  var lista = [];

  //retornar a palavra adicionada pelo usuário
  var vocab_word = TextEditingController();

  @override
  void initState() {
    lista.add("春: Primavera");
    lista.add("犬: Cachorro");
    lista.add("料理: Comida");
    lista.add("願い: Desejo");
    lista.add("冬: Inverno");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(30),
        color: Colors.brown.shade200,
        // ---------------- ListView ------------------------------------------------
        
        child: ListView.builder(
          //quantidade de elementos da lista
          itemCount: lista.length,

          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0, bottom: 10.0),
              color: Colors.grey.shade100,
              shadowColor: Colors.grey,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                //leading: Icon(Icons.arrow_right),
                title: Text(
                  lista[index],
                  style: TextStyle(fontSize: 20),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    //remover um item da lista
                    setState(() {
                      lista.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Palavra removida com sucesso'),
                        duration: Duration(seconds: 2),
                      ));
                    });
                  },
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
                    'Adicionar uma Palavra:',
                    style: TextStyle(fontSize: 16),
                  ),

                  content: TextField(
                    controller: vocab_word,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                    ),
                  ),

                  actions: [
                    TextButton(
                      child: Text('ok'),
                      onPressed: () {
                        setState(() {
                          var msg = '';
                          if (vocab_word.text.isNotEmpty) {
                            lista.add(vocab_word.text);
                            vocab_word.clear();
                            msg = 'Palavra adicionada com sucesso.';
                          } 

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pop(context);
                        },
                        );
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
}
