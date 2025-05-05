// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:chewie/chewie.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _videoController;
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   Future<void> _initializeVideoPlayer() async {
//     _videoController = VideoPlayerController.network(widget.videoUrl);
//     await _videoController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoController,
//       autoPlay: true,
//       looping: false,
//       aspectRatio: _videoController.value.aspectRatio,
//     );
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
//         ? Chewie(controller: _chewieController!)
//         : Center(child: CircularProgressIndicator());
//   }
// }
