import 'package:flutter/material.dart';
import 'package:flutter_application/home_page/content_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MediaPlayerScreen extends StatefulWidget {
  final String mediaUrl;
  final MediaType mediaType;
  final String title;

  const MediaPlayerScreen({
    super.key,
    required this.mediaUrl,
    required this.mediaType,
    required this.title,
  });

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    widget.mediaType == MediaType.video
        ? _initializeVideoPlayer()
        : _initializeAudioPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoController = VideoPlayerController.network(widget.mediaUrl);
    await _videoController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoController.value.aspectRatio,
    );
    setState(() {});
  }

  Future<void> _initializeAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    try {
      await _audioPlayer!.setUrl(widget.mediaUrl);
      _audioPlayer!.play();
    } catch (e) {
      print("Error initializing audio: $e");
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _buildPlayer(),
    );
  }

  Widget _buildPlayer() {
    if (widget.mediaType == MediaType.video) {
      return _chewieController?.videoPlayerController.value.isInitialized ??
              false
          ? Chewie(controller: _chewieController!)
          : Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.audiotrack, size: 100),
        _buildAudioControls(),
        StreamBuilder<Duration>(
          stream: _audioPlayer?.positionStream,
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            final duration = _audioPlayer?.duration ?? Duration.zero;
            return Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              max: duration.inSeconds.toDouble(),
              onChanged: (value) =>
                  _audioPlayer?.seek(Duration(seconds: value.toInt())),
            );
          },
        )
      ],
    );
  }

  Widget _buildAudioControls() {
    return StreamBuilder<PlayerState>(
      stream: _audioPlayer?.playerStateStream,
      builder: (context, snapshot) {
        final playing = snapshot.data?.playing ?? false;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(playing ? Icons.pause : Icons.play_arrow),
              onPressed: () =>
                  playing ? _audioPlayer?.pause() : _audioPlayer?.play(),
              iconSize: 40,
            ),
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: () => _audioPlayer?.stop(),
              iconSize: 40,
            ),
          ],
        );
      },
    );
  }
}
