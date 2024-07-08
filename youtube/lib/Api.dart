import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyAUVCbs4iypSDGg1I0IjEt8uJJHb3TzkyY";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {

  Future<List<Video>> pesquisar(String pesquisa) async {
    final uri = Uri.parse(URL_BASE + "search").replace(
      queryParameters: {
        'part': 'snippet',
        'type': 'video',
        'maxResults': '20',
        'order': 'date',
        'key': CHAVE_YOUTUBE_API,
        'channelId': ID_CANAL,
        'q': pesquisa,
      },
    );

    http.Response response = await http.get(uri);

    if(response.statusCode == 200) {
      
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>(
        (map){
          return Video.fromJson(map);
        }
      ).toList();

      return videos;

      /*
      for (var video in dadosJson["items"]){
        print("Resultado: " + video.toString());
      }
      */

      //print("resultado: " + dadosJson["items"][0]["snippet"]["title"].toString());

    } else {
      print("Erro na requisição: ${response.statusCode}");
    }

  return pesquisar(pesquisa);
  }
}
