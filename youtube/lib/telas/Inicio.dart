import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {
  final String pesquisa;

  Inicio(this.pesquisa);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  YoutubePlayerController? _controller;
  String? videoId;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '', // Inicialmente vazio
      flags: const YoutubePlayerFlags(
        mute: true,
        autoPlay: false,
      ),
    )..addListener(listener);
  }

  Future<List<Video>> _listarVideos(String pesquisa) async {
    Api api = Api();
    return await api.pesquisar(pesquisa);
  }

  void _playVideo(String id) {
    if (_controller != null) {
      _controller?.load(id);
    }
  }

  void listener() {
    if (_controller?.value.isReady ?? false) {
      setState(() {
        _isPlayerReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_controller != null && videoId != null)
          YoutubePlayer(
            controller: _controller!,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              setState(() {
                _isPlayerReady = true;
              });
            },
          ),
        Expanded(
          child: FutureBuilder<List<Video>>(
            future: _listarVideos(widget.pesquisa),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        List<Video>? auxVideoList = snapshot.data;
                        Video auxVideo = auxVideoList![index];

                        return GestureDetector(
                          onTap: () {
                            _playVideo(auxVideo.id!);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(auxVideo.imagem),
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(auxVideo.titulo),
                                subtitle: Text(auxVideo.canal),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Center(
                      child: Text("Nenhum dado a ser exibido"),
                    );
                  }
              }
            },
          ),
        ),
      ],
    );
  }
}
