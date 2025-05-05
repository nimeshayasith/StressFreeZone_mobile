import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MediaPlayerScreen extends StatefulWidget {
  final String mediaUrl;
  final String title;

  const MediaPlayerScreen({
    super.key,
    required this.mediaUrl,
    required this.title,
  });

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  void _initializeMedia() {
    if (widget.mediaUrl.endsWith(".mp4")) {
      _initializeVideoPlayer(widget.mediaUrl);
    } else {
      _initializeAudioPlayer();
    }
  }

  Future<void> _initializeVideoPlayer(String videoUrl) async {
    final file = await DefaultCacheManager().getSingleFile(videoUrl);
    _videoController = VideoPlayerController.file(file);
    await _videoController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true,
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
    _videoController?.dispose();
    _chewieController?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _videoController != null && _videoController!.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : _audioPlayer != null
              ? _buildAudioPlayer()
              : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildAudioPlayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.audiotrack, size: 100),
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
              icon: const Icon(Icons.stop),
              onPressed: () => _audioPlayer?.stop(),
              iconSize: 40,
            ),
          ],
        );
      },
    );
  }
}
