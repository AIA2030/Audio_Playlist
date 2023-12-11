import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class MusicPlaylist extends StatefulWidget {
  const MusicPlaylist({super.key});

  @override
  State<MusicPlaylist> createState() => _MusicPlaylistState();
}

class _MusicPlaylistState extends State<MusicPlaylist> {

  final AssetsAudioPlayer audioPlayer  = AssetsAudioPlayer();
  double screenHeight =0;
  double screenWidth =0;
  final Color mainColor = Color(0xff181c27);
  final Color inactiveColor = Color(0xff5d6169);
  List<Audio> audioList = [
    Audio('assets/audio/ambient_classical.mp3', metas: Metas(title: "- Ambient Classical", image: MetasImage.asset('assets/image/ambient_classical.png',))),
    Audio('assets/audio/tvari_tokyo_cafe.mp3', metas: Metas(title: "- Tvari Tokyo Cafe", image: MetasImage.asset('assets/image/tvari_tokyo_cafe.png',))),
    Audio('assets/audio/coniferous_forest.mp3', metas: Metas(title: "- Coniferous Forest", image: MetasImage.asset('assets/image/coniferous_forest.png',))),
    Audio('assets/audio/reflected_light.mp3', metas: Metas(title: "- Reflected Light", image: MetasImage.asset('assets/image/reflected_light.png',))),
    Audio('assets/audio/relaxing.mp3', metas: Metas(title: "- Relaxing", image: MetasImage.asset('assets/image/relaxing.png',))),
    Audio('assets/audio/hauwii_vibes.mp3', metas: Metas(title: "- Hauwii Vibes", image: MetasImage.asset('assets/image/hawuii_vibes.png',))),

  ];

   @override
   void initState() {
     super.initState();
     setupPlaylist();
   }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

   void setupPlaylist() async {
     audioPlayer.open(Playlist(audios: audioList),
     autoStart: false, loopMode: LoopMode.playlist);
  }


  Widget playlistImage() {
     return Container(
     height: screenHeight * 0.25,
     width: screenHeight * 0.25,
     child: ClipRRect(
       borderRadius: BorderRadius.circular(20.0),
       child: Image.asset('assets/image/lofi_music.jpg', fit: BoxFit.cover,)));

    }

    Widget playlistTitle(){
     return Text('Lofi Playlist', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),);
  }

  Widget playButton(){
  return Container(
  width: screenWidth * 0.10,
  height: screenWidth * 0.03,

  child: TextButton(
  onPressed: () => audioPlayer.playlistPlayAtIndex(0),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.playlist_play, color: mainColor,),
  SizedBox(width: 5,),
  Text('play', style: TextStyle(color: mainColor),),
  ],),

  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))))));
  }

  Widget playlist(RealtimePlayingInfos realtimePlayingInfos){
     return Container(
     height: screenHeight * 0.35,
     alignment: Alignment.bottomLeft,
     child: ListView.builder(shrinkWrap: true, itemCount: audioList.length, itemBuilder: (context, index){
       return playlistItem(index );
  }
  ));
  }
//RealtimePlayingInfos realtimePlayingInfos
  Widget playlistItem(int index,  ){
     return InkWell(
     onTap: () => audioPlayer.playlistPlayAtIndex(index),
  splashColor: Colors.transparent,
  highlightColor: mainColor,
  child: Container(
  height: screenHeight * 0.07,
  child: Padding(padding: const EdgeInsets.only(left: 20, right: 20),
  child: Row(
  children: [
    Text('0${index + 1 }', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
  Expanded(child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text( audioList[index].metas.title.toString(), style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold,),),
    SizedBox(height: screenHeight *0.005,),],

  )),
    //Icon(Icons.play_circle_outline_rounded, color: inactiveColor, ),

    IconButton(onPressed:  () => audioPlayer.playOrPause(), icon: Icon(Icons.play_circle_outline_rounded, color: inactiveColor), iconSize: screenHeight * 0.07,
      splashColor: Colors.transparent, highlightColor: Colors.transparent, )

  ],


  ),
  ),
  ),
     );
  }

  Widget bottomPlayContainer(RealtimePlayingInfos realtimePlayingInfos, ){
     return Container(
     height: screenHeight * 0.1,
       decoration: BoxDecoration(
         color: Colors.blue,
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
       child: Padding(
         padding: const EdgeInsets.only(left: 8.0),
         child: Row(
           children: [
             Title(color: mainColor, child: Text("Lofi Playlist", ),),
             SizedBox(width: screenWidth * 0.37),

             IconButton(
                 icon: Icon(realtimePlayingInfos.isPlaying
                     ? Icons.pause_circle_outline_rounded
                     : Icons.play_circle_outline_rounded),
                 iconSize: screenHeight * 0.07,
                 splashColor: Colors.transparent,
                 highlightColor: Colors.transparent,
                 color: mainColor,
                 onPressed: () => audioPlayer.playOrPause()),

             SizedBox(width: screenWidth * 0.03),

           ],
         ),
       ),
     );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mainColor,

      body: audioPlayer.builderRealtimePlayingInfos(builder: (context, realtimePlayingInfos){
        if (realtimePlayingInfos != null){
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              playlistImage(),
              SizedBox(height: screenHeight * 0.02,),
              playlistTitle(),
              SizedBox(height: screenHeight * 0.02,),
              playButton(),
              SizedBox(height: screenHeight * 0.02,),
              playlist(realtimePlayingInfos),
              bottomPlayContainer(realtimePlayingInfos)

            ],
          );
        }
        else{
          return Column();
        }
        }
      ),
    ); }}
