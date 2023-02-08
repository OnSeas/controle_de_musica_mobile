import 'package:controle_de_musica_mobile/api/api-service.dart';
import 'package:controle_de_musica_mobile/components/music-edit.dart';
import 'package:controle_de_musica_mobile/components/music-info.dart';
import 'package:controle_de_musica_mobile/views/music-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/music.dart';

class MusicTile extends StatelessWidget {
  final Music music;
  final int I;

  final ApiService api;

  const MusicTile(this.music, this.I, this.api); // Recebendo a musica e o index para construir a tile

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
        width: 100, // Largura de 100%
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) => MusicEdit(music),
                  )
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                deleteAlertDialog(context);
              },
            )
          ],
        )
      )
    );
  }

  deleteAlertDialog(BuildContext context) {
  // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      onPressed:  () {
        api.deleteCase(music.idMusica);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Deletar"),
      content: Text("Você deseja excluir a música " + music.titulo + "?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}