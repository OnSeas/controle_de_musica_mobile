class Music {
  final String idMusica;
  final String titulo;
  final TipoMusical estiloMusical;
  final int duracao;
  final String artista;
  final String compositor;
  final bool favorito;

  Music( // Construtor
    {required this.idMusica,
    required this.titulo,
    required this.estiloMusical,
    required this.duracao,
    required this.artista,
    required this.compositor,
    required this.favorito});

    factory Music.fromJson(Map<String, dynamic> json) { // Conversão entre jason e music
    return Music(
      idMusica: (json['idMusica'] as int).toString(),
      titulo: (json['titulo'] as String),
      estiloMusical: stringToTipoMusical(json['estiloMusical'] as String), // recebe uma string e transforma para o tipo enum
      duracao: (json['duracao'] as int),
      artista: (json['artista'] as String),
      compositor: (json['compositor'] as String),
      favorito: (json['favorito'] as bool),
    );
  }
}

enum TipoMusical{ // Enum do Tipo musica
    POP,
    REB,
    MPB,
    ROCK,
    FOLK;
}

TipoMusical stringToTipoMusical(String value){ // Função para utilizar o enum com o jason
  return TipoMusical.values.firstWhere((element) => 
  element.toString().split('.')[1].toUpperCase()==value.toUpperCase());
}