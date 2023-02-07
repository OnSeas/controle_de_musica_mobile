import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/music.dart';

class MusicTile extends StatelessWidget {
  final Music music;
  final int I;

  const MusicTile(this.music, this.I); // Recebendo a musica e o index para construir a tile

  @override
  Widget build(BuildContext context) { 
    return ListTile(
      leading: Text(I.toString()), // Para mostrar a numeração das músicas
      title: Text(music.titulo),
      subtitle: Text(music.artista),
      trailing: Container(
        width: 100, // Largura de 100%
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
              },
            )
          ],
        )
      )
    );
  }
}