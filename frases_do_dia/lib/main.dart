import 'dart:math';

import 'package:flutter/material.dart';

void main(){

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));

}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _frases = [
    "Todos aqueles que não conhecem a si mesmo, estão fadados a falhar.",
    "A vida das pessoas não acaba quando elas morrem, mas sim quando perdem a fé.",
    "Quem quebra as regras pode ser considerado lixo, mas quem abandona seus amigos é pior que lixo.",
    "O lugar onde as pessoas pensam em você é o lugar para onde você deve sempre retornar!",
  ];

  var _fraseGerada = "Clique abaixo para gerar uma frase!";

  void _gerarFrase(){

    var numSorteado = Random().nextInt(_frases.length);
    
    setState(() {
      _fraseGerada =  _frases[numSorteado];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do dia"),
        backgroundColor: Color.fromARGB(255, 76, 175, 80),
      ),
      body: Center(
        child: Container(
        padding: EdgeInsets.all(16),
        //width: double.infinity,
        /*decoration: BoxDecoration(
          border: Border.all(width: 3, color: Colors.amber)
        ),*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("images/logo.png"),
            Text(
              _fraseGerada,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.black
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 76, 175, 80)
              ),
              child: Text(
                "Nova Frase",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              onPressed: _gerarFrase,
            )
          ],
        ),
      ),
        ),
    );
  }
}