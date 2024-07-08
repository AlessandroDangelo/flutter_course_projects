
import 'package:flutter/material.dart';

class Customsearchdelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        }, 
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context, "");
        }, 
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      close(context, query);
    });
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /*
    List<String> lista = [];

    if(query.isNotEmpty){
      lista = ["a", "b", "c", "d", "e", "f"].where(
        (texto) => texto.toLowerCase().startsWith(query.toLowerCase())
      ).toList();
    }

    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: (){
            close(context, lista[index]);
          },
          title: Text(lista[index]),
        );
      }
    );
    */
    return Container();
  }



}