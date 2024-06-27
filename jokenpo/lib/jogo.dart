// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'dart:math';

class Jogo extends StatefulWidget {
  Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  var _imagemApp = AssetImage("images/padrao.png");
  var _mensagem = "Escolha uma opção abaixo:";

  void _opcaoSelecionada(String escolhaUsuario){

    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    print("Escolha do App: " + escolhaApp);
    print("Escolha do Usuário: " + escolhaUsuario);

    //Exibição da imagem escolhida pelo App
    switch (escolhaApp){
      case "pedra":
        setState(() {
          _imagemApp = AssetImage("images/pedra.png");
        });
        break;
      case "papel":
        setState(() {
          _imagemApp = AssetImage("images/papel.png");
        });
        break;
      case "tesoura":
        setState(() {
          _imagemApp = AssetImage("images/tesoura.png");
        });
        break;
    }

    //Validação do ganhador
    //Usuario Ganhador
    if(
        (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
        (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
        (escolhaUsuario == "papel" && escolhaApp == "pedra")
    ){
      setState(() {
        _mensagem = "Parabéns! Você ganhou!";
      });
    //App Ganhador
    }else if(
        (escolhaApp == "pedra" && escolhaUsuario == "tesoura") ||
        (escolhaApp == "tesoura" && escolhaUsuario == "papel") ||
        (escolhaApp == "papel" && escolhaUsuario == "pedra")
    ){
      setState(() {
        _mensagem = "Você perdeu! Tente novamente!";
      });
    }else{
      setState(() {
        _mensagem = "Empate!";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenpPo"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Text
          //imagem
          //resultado text
          //Linha 3 imagens
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Image(image: this._imagemApp), //Acrescentar this aqui?
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            child: Text(
              this._mensagem,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [/*
              Image.asset("images/papel.png", height: 100,),
              Image.asset("images/pedra.png", height: 100,),
              Image.asset("images/tesoura.png", height: 100,),
              */
              GestureDetector(
                onTap: () => _opcaoSelecionada("pedra"),
                child: Image.asset("images/pedra.png", height: 100,),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("papel"),
                child: Image.asset("images/papel.png", height: 100,),
              ),
              GestureDetector(
                onTap: () => _opcaoSelecionada("tesoura"),
                child: Image.asset("images/tesoura.png", height: 100,),
              ),
            ],
          )
        ],
      ),
    );
  }
}