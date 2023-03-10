import 'package:controle_de_musica_mobile/components/music-tile-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api-service.dart';
import '../models/music.dart';

class MusicListFavorite extends StatefulWidget {
  const MusicListFavorite({super.key});

  @override
  State<MusicListFavorite> createState() => _MusicListFavoriteState();
}

class _MusicListFavoriteState extends State<MusicListFavorite> {
  ApiService api = ApiService(); // singleton da api
  List<Music> musicas = []; // Lista de músicas

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // APP BAR

      appBar: AppBar(
        title: const Text('Músicas')
      ),

      // LISTA DE MÚSICAS

      body: RefreshIndicator( // Recarregar a página ao puxar pra baixo
        onRefresh: _getData, // Função asincrona que recarrega a lista de acordo com os dados do backend
        child: Container(
          child: Center( // Alinhamento no centro
            child: FutureBuilder<List<Music>>(
              future: loadMusicList(),
              builder: (context, AsyncSnapshot<List<Music>> snapshot) {
                if (!snapshot.hasData) { // Se não conseguiu conectar com o backend
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (musicas.length <= 0){ // Se não tiver musicas cadastradas
                  return Center(
                    child: Text('Nenhuma musica adcionada, crie uma música'),
                  );
                }
                return ListView.builder( // Lista de músicas
                  itemCount: musicas.length,
                  itemBuilder: ((context, i) => MusicTileView(musicas.elementAt(i), i+1, api)) // Chama o MusicTile para construir a apresentação de cada música
                );
              },
            )
          ),
        ),
      ),
    );
  }

  // FUNÇÃO PARA CARREGAR MÚSICAS

  Future<List<Music>> loadMusicList() async{
    print("Carregando favoritas");
    Future<List<Music>> futureMusicas = api.getfavorites(); // pegando músicas do backend

    futureMusicas.then((musicList) { // atualizando a lista de músicas craida
      this.musicas = musicList;
    });

    return futureMusicas;
  }

  // Pegar os dados do backend quando recarregar a página
  Future<void> _getData() async {
    setState(() {
      loadMusicList();
    });
  }

  @override
  void initState() { // Iniciar o estado, chama a função carregar musicas quando o app inicia
    super.initState();
    loadMusicList();
  }
}