import 'package:flutter/material.dart';
// import 'package:flip_card/flip_card.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

// class Flashcard {
//   final String cardFront;
//   final String cardBack;

//   Flashcard({required this.cardFront, required this.cardBack});
// }

class _VocabularyPageState extends State<VocabularyPage> {
  //lista dinâmica para armazenamento dos flashcards
  var lista = [];

  // List<Flashcard> flashcards =[
  //   Flashcard(cardFront: "春", cardBack: "Primavera"),
  //   Flashcard(cardFront: "犬", cardBack: "Cachorro"),
  //   Flashcard(cardFront: "料理", cardBack: "Comida"),
  //   Flashcard(cardFront: "願い", cardBack: "Desejo"),
  //   Flashcard(cardFront: "冬", cardBack: "Inverno"),
  // ];

  // int currentindex = 0;

  //retornar a palavra adicionada pelo usuário
  var vocab_word = TextEditingController();

  @override
  void initState() {    
    lista.add("春: Primavera");
    lista.add("犬: Cachorro");
    lista.add("料理: Comida");
    lista.add("願い: Desejo");
    lista.add("冬: Inverno");
    lista.add("海: Mar");
    lista.add("月: Lua/Mês");
    lista.add("年: Ano");
    lista.add("こんにちは: Olá");
    lista.add("おやすみなさい: Boa noite");
    lista.add("熱い: Quente");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              // shadowColor: Colors.black,
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
            
            // return Container(
            //   margin: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0, bottom: 10.0),
            //   color: Colors.grey.shade100,

            //     child: Column(
            //       children: [
            //         SizedBox(
            //           width: 100,
            //           height: 60,
            //           child: FlipCard(
            //             direction: FlipDirection.VERTICAL, // default
            //             front: Container(
            //                 child: Text(
            //                   flashcards[index].cardFront,
            //                   style: TextStyle(fontSize: 20, color: Colors.black,decorationColor: Colors.red,),
            //                 ),
                  
            //             ),
            //             back: Container(
            //                 child: Text(
            //                   flashcards[index].cardBack,
            //                   style: TextStyle(fontSize: 20, color: Colors.black,decorationColor: Colors.red,),
            //                 ),
                            
            //             ),
            //           )
            //         )
            //       ],
            //     )              
            // );            
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