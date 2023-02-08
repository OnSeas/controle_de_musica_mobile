import 'dart:convert';
import 'dart:ffi';

import 'package:controle_de_musica_mobile/views/create-music.dart';
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
      print("resposta 404 - getmusicas");
      return <Music>[];
    } else {
      throw "Erro ao encontrar músicas!";
    }
  }

  // Mandar requisição para criar
  Future<Music> createMusic(Music music) async{
    // Criação do estilo de dado jason
    Map data ={
      'titulo': music.titulo,
      'estiloMusical': music.estiloMusical.toString().split('.')[1],
      'duracao': music.duracao,
      'artista': music.artista,
      'compositor': music.compositor,
    };

    final Response res = await post( // Criar uma música
  
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    ); // Conexão com backend, neste caso manda a url, hedears e os dados definida anteriormente.

    if(res.statusCode == 200){
      print("Teve resposta 200 do backend - criar musica");
      return Music.fromJson(json.decode(res.body)); // devolver a musica criada na função
    }else {
      print(res.statusCode);
      print(data);
      throw "Erro ao criar músicas!";
    }  
  }

  // Editar músicas
  Future<Music> updateMusic(int id, Music music) async {
    // Criação do estilo de dado jason
    Map data ={
      'titulo': music.titulo,
      'estiloMusical': music.estiloMusical.toString().split('.')[1],
      'duracao': music.duracao,
      'artista': music.artista,
      'compositor': music.compositor,
    };

    final Response res = await patch(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (res.statusCode == 200) {
      print("Teve resposta 200 do backend - atualizar musica");
      return Music.fromJson(json.decode(res.body));
    } else {
      throw Exception('Erro ao atualizar música!');
    }
  }

  // Deletar Músicas
  Future<void> deleteCase(int id) async {
    Response res = await delete(Uri.parse('$apiUrl/$id'));

    if (res.statusCode == 200) {
      print("Teve resposta 200 do backend - deletar musica");
    } else {
      throw "Erro ao deletar música!";
    }
  }
}