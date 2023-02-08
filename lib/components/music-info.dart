import 'package:controle_de_musica_mobile/models/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MusicInfo extends StatelessWidget {

  final Music music;

  const MusicInfo(this.music);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações da música'),
      ),
      body: Center(
        child: Column(
          children: [

            // Título 
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Text(
                music.titulo,
                style: const TextStyle(
                  fontSize: 30.0
                )
              ),
            ),

            // Artista
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                'Artista: ${music.artista}',
                style: const TextStyle(
                  fontSize: 20.0
                )
              ),
            ),

            // Compositor  
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                'Compositor: ${music.compositor}',
                style: const TextStyle(
                  fontSize: 20.0
                )
              ),
            ),

            // Duração
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                'Duração: ${music.duracao} segundos',
                style: const TextStyle(
                  fontSize: 20.0
                )
              ),
            ),

            // Estilo musical
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Text(
                'Duração: ${music.estiloMusical.toString().split('.')[1]}',
                style: const TextStyle(
                  fontSize: 20.0
                )
              ),
            )
          ],
        ),
      )
    );
  }
}