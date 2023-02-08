import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api-service.dart';
import '../models/music.dart';

class MusicEdit extends StatefulWidget {
  final Music music;

  const MusicEdit(this.music);

  @override
  State<MusicEdit> createState() => _MusicEditState();
}

class _MusicEditState extends State<MusicEdit> {

final ApiService api = ApiService();

  // Key do form
  final _form = GlobalKey<FormState>();

  TipoMusical? _tipoMusical = TipoMusical.FOLK; // Para movimentar o radio

  // Strings para salvar o conteúdo
  late int id;
  String tipoMusical = "FOLK";
  final _tituloController = TextEditingController();
  final _artistaController = TextEditingController();
  final _compositorController = TextEditingController();
  final _duracaoController = TextEditingController();

  @override
  void initState() {
    id = widget.music.idMusica;
    _tituloController.text = widget.music.titulo;
    _artistaController.text = widget.music.artista;
    _compositorController.text = widget.music.compositor;
    _duracaoController.text = widget.music.duracao.toString();
    tipoMusical = widget.music.estiloMusical.toString().split('.')[1];
    switch(tipoMusical){
      case 'FOLK': 
        _tipoMusical = TipoMusical.FOLK;
        break;
      case 'MPB': 
        _tipoMusical = TipoMusical.MPB;
        break;
      case 'POP': 
        _tipoMusical = TipoMusical.POP;
        break;
      case 'REB': 
        _tipoMusical = TipoMusical.REB;
        break;
      case 'ROCK': 
        _tipoMusical = TipoMusical.ROCK;
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar uma música'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),

        // FORMULÁRIO
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget> [

                // Título
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: TextFormField(
                    controller: _tituloController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                ),

                // Artista
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: TextFormField(
                    controller: _artistaController,
                    decoration: InputDecoration(labelText: 'Artista'),
                  ),
                ),

                // Compositor
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: TextFormField(
                    controller: _compositorController,
                    decoration: InputDecoration(labelText: 'Compositor'),
                  ),
                ),

                // Duração
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: TextFormField(
                    controller: _duracaoController,
                    decoration: InputDecoration(labelText: 'duração'),
                    keyboardType: TextInputType.number,
                  ),
                ),

                //Estilo Musical
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Column(
                    children: <Widget> [
                      const Text(
                        'Estilo Musical',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      ListTile(
                        title: const Text('Folk'),
                        leading: Radio<TipoMusical>(
                          value: TipoMusical.FOLK,
                          groupValue: _tipoMusical,
                          onChanged: (TipoMusical? value) {
                            setState(() {
                              _tipoMusical = value!;
                              tipoMusical = "FOLK";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('MPB'),
                        leading: Radio<TipoMusical>(
                          value: TipoMusical.MPB,
                          groupValue: _tipoMusical,
                          onChanged: (TipoMusical? value) {
                            setState(() {
                              _tipoMusical = value!;
                              tipoMusical = "MPB";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('POP'),
                        leading: Radio<TipoMusical>(
                          value: TipoMusical.POP,
                          groupValue: _tipoMusical,
                          onChanged: (TipoMusical? value) {
                            setState(() {
                              _tipoMusical = value!;
                              tipoMusical = "POP";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('RnB'),
                        leading: Radio<TipoMusical>(
                          value: TipoMusical.REB,
                          groupValue: _tipoMusical,
                          onChanged: (TipoMusical? value) {
                            setState(() {
                              _tipoMusical = value!;
                              tipoMusical = "REB";
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Rock'),
                        leading: Radio<TipoMusical>(
                          value: TipoMusical.ROCK,
                          groupValue: _tipoMusical,
                          onChanged: (TipoMusical? value) {
                            setState(() {
                              _tipoMusical = value!;
                              tipoMusical = "ROCK";
                            });
                          },
                        ),
                      )
                    ],
                  )
                ),

                // Botão de salvar
                Container(
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                  width: 250,
                  child: ButtonTheme(
                      minWidth:double.infinity,
                      child: ElevatedButton(

                        // Costumização do botão
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          padding: EdgeInsets.all(18)
                        ),

                        // Quando pressionado
                        onPressed: () {
                          if(true){
                            _form.currentState!.save();
                            api.updateMusic(
                              id,
                              Music(
                                idMusica: 0,
                                titulo: _tituloController.text,
                                estiloMusical: stringToTipoMusical(tipoMusical),
                                duracao: int.parse(_duracaoController.text),
                                artista: _artistaController.text,
                                compositor: _compositorController.text,
                                favorito: false)
                            );

                            Navigator.pop(context);
                          }
                        },

                        // Texto dentro do botão
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            fontSize: 20.0
                          ),
                        ),
                        
                      ),
                  )
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}