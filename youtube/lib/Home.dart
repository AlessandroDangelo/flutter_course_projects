import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {

    List telas = [
      Inicio( _resultado ),
      EmAlta(),
      Inscricao(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(

          "imagens/youtube.png",
          width: 98,
          height: 22,
          ),
        actions: [

          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String? res = await showSearch(context: context, delegate: Customsearchdelegate(),);
              setState(() {
                _resultado = res!;
              });
            }, 
          ),

          /*
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              print("acao: videocam");
            }, 
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              print("acao: conta");
            }, 
          )
          */
        ]
        
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            //backgroundColor: Colors.orange,
            label: "Início",
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.red,
            label: "Em alta",
            icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.blue,
            label: "Incrições",
            icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
            //backgroundColor: Colors.green,
            label: "Biblioteca",
            icon: Icon(Icons.folder)
          ),
        ],
      ),
    );
  }
}