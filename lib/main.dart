import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_player/music_playlist.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Audio Playlist'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPlaying = false;
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();

  }
    @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(


        leading: IconButton (icon: Icon(Icons.menu), onPressed: () {  },),

        title: Center( child: Text(widget.title),),


        actions: [
          IconButton(icon: Icon(Icons.account_circle_rounded),onPressed: () {  },),
        ],

        backgroundColor: Colors.blue,

      ),
      body: MusicPlaylist (),

    );
  }
}
