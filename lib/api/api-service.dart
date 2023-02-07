import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';

import '../models/music.dart';

class ApiService {
  final String apiUrl = "http://10.101.4.108:8081/musica"; // mudar o ip sempre que for rodar

  // Listar todas
  Future<List<Music>> getMusicas() async {
    Response res = await get(Uri.parse(apiUrl)); // await e o método que chama no backend, neste caso get

    if(res.statusCode == 200){
      print("Teve resposta 200 do backend - getmusicas");
      List<dynamic> body = jsonDecode(res.body);
      List<Music> musicas = body.map((dynamic item) => Music.fromJson(item)).toList();
      return musicas;
    }else if (res.statusCode == 404) {
      return <Music>[];
    } else {
      throw "Erro ao encontrar músicas!";
    }
  }

  // Mandar requisição para criar
  Future<Music> criarMusica(Music music) async{
    Map data ={ // Criação do estilo de dado
      'titulo': music.titulo,
      'estiloMusical': music.estiloMusical,
      'duracao': music.duracao,
      'artista': music.artista,
      'compositor': music.compositor
    };

    final Response res = await post( // Criar uma música
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
      ); // Conexão com backend, neste caso manda a url, hedears e a data definida anteriormente.

    if(res.statusCode == 200){
      print("Teve resposta 200 do backend - criar musica");
      return Music.fromJson(json.decode(res.body)); // devolver a musica criada na função
    }else {
      throw "Erro ao criar músicas!";
    }  
  }

}