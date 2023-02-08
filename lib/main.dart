import 'package:controle_de_musica_mobile/routes/app-routes.dart';
import 'package:controle_de_musica_mobile/views/create-music.dart';
import 'package:controle_de_musica_mobile/views/music-list-favorite.dart';
import 'package:controle_de_musica_mobile/views/music-list-view.dart';
import 'package:controle_de_musica_mobile/views/music-list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpMusic-material',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'UpMusic'),
      routes: {
        AppRoutes.MUSIC_LIST:(context) => MusicList(),
        AppRoutes.CREATE_MUSIC:(context) => CreateMusic(),
        AppRoutes.MUSIC_LIST_VIEW:(context) => MusicListView(),
        AppRoutes.MUSIC_LIST_FAVORITE:(context) => MusicListFavorite()
      },
    );
  }
}

// classe HOME

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: const Center(
                child: Text(
                  'Bem-Vindo ao UpMusic!',
                  style: TextStyle(
                    fontSize: 35.0
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: const Text(
                'A página inicial ainda está em construção, mas você pode acessar as funcionalidades pela barra de navegação a baixo.',
                style: TextStyle(
                  fontSize: 20.0
                ),
              )
            ),
          ],
        ) 
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Padding(padding: const EdgeInsets.all(12.0), child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.library_music),
                onPressed: (() {
                  Navigator.pushNamed(context, AppRoutes.MUSIC_LIST_VIEW);
                })
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: (() {
                  Navigator.pushNamed(context, AppRoutes.MUSIC_LIST_FAVORITE);
                })
              ),
              IconButton(
                icon: Icon(Icons.admin_panel_settings_rounded),
                onPressed: (() {
                  Navigator.pushNamed(context, AppRoutes.MUSIC_LIST);
                })
              ),
            ],
          ),),
        ),
      )
    );
  }
}
