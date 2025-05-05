// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

// class AudioPlayerWidget extends StatefulWidget {
//   @override
//   _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
// }

// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   Future<void> _init() async {
//     await _audioPlayer.setUrl(widget.mediaUrl);
//     _audioPlayer.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(Icons.audiotrack, size: 100),
//         StreamBuilder<PlayerState>(
//           stream: _audioPlayer.playerStateStream,
//           builder: (context, snapshot) {
//             final playing = snapshot.data?.playing ?? false;
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(playing ? Icons.pause : Icons.play_arrow),
//                   onPressed: () =>
//                       playing ? _audioPlayer.pause() : _audioPlayer.play(),
//                   iconSize: 40,
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.stop),
//                   onPressed: () => _audioPlayer.stop(),
//                   iconSize: 40,
//                 ),
//               ],
//             );
//           },
//         ),
//         StreamBuilder<Duration>(
//           stream: _audioPlayer.positionStream,
//           builder: (context, snapshot) {
//             final position = snapshot.data ?? Duration.zero;
//             final duration = _audioPlayer.duration ?? Duration.zero;
//             return Slider(
//               value: position.inSeconds.toDouble(),
//               min: 0,
//               max: duration.inSeconds.toDouble(),
//               onChanged: (value) =>
//                   _audioPlayer.seek(Duration(seconds: value.toInt())),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
