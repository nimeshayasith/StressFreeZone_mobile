import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/video.dart';
import '../../services/video_service.dart';
import '../players/media_player_screen.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String selectedCategory = 'All';
  int _selectedIndex = 1;

  List<Video> videoList = [];
  final VideoService _videoService = VideoService();
  final Map<String, VideoPlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      final videos = await _videoService.fetchVideos();
      setState(() {
        videoList = videos;
      });

      // Preload video controllers
      for (var video in videos) {
        if (!_videoControllers.containsKey(video.url)) {
          _videoControllers[video.url] =
              VideoPlayerController.network(video.url)
                ..initialize().then((_) {
                  setState(() {});
                });
        }
      }
    } catch (e) {
      print('Error fetching videos: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/discover');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/progress');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  void dispose() {
    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredVideos = selectedCategory == 'All'
        ? videoList
        : videoList
            .where((video) => video.category == selectedCategory)
            .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'All',
                'Meditation',
                'Movements',
                'Soundscape',
                'WorkRelief',
                'LearnMore'
              ]
                  .map((category) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredVideos.isNotEmpty
                ? ListView.separated(
                    itemCount: filteredVideos.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return VideoItem(
                          video: filteredVideos[index],
                          controller:
                              _videoControllers[filteredVideos[index].url]);
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(29, 172, 146, 1.0),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final Video video;
  final VideoPlayerController? controller;

  const VideoItem({super.key, required this.video, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: controller != null && controller!.value.isInitialized
          ? AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: VideoPlayer(controller!),
            )
          : Image.asset('assets/video_placeholder.png',
              width: 100, height: 60, fit: BoxFit.cover),
      title: Text(video.title),
      subtitle: Text(video.category),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MediaPlayerScreen(
              mediaUrl: video.url,
              title: video.title,
            ),
          ),
        );
      },
    );
  }
}
