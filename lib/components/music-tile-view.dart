import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api-service.dart';
import '../models/music.dart';
import 'music-info.dart';

class MusicTileView extends StatelessWidget {
  final Music music;
  final int I;

  final ApiService api;

  const MusicTileView(this.music, this.I, this.api); 

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(I.toString()), // Para mostrar a numeração das músicas
      title: Text(music.titulo),
      subtitle: Text(music.artista),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicInfo(music),
          )
        );
      },
      trailing: Container(
        width: 60, // Largura de 100%
        child: Row(
          children: [
              if (music.favorito == false) ...[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    api.favoriteMusic(music.idMusica);
                  },
                )
              ] else ...[
                IconButton(
                  icon: Icon(Icons.favorite),
                  color: Theme.of(context).colorScheme.primary,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    api.unFavoriteMusic(music.idMusica);
                  },
                )
              ],
          ],
        )
      )
    );
  }
}