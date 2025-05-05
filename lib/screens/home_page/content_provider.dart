import 'package:flutter/material.dart';
import 'package:flutter_application/models/video.dart';
import 'package:flutter_application/services/video_service.dart';

class ContentProvider with ChangeNotifier {
  List<Video> _suggestedContent = [];
  List<Video> _trendingContent = [];
  List<Video> _rainAndStormContent = [];
  List<Video> _meditationTypes = [];
  List<Video> _breathingSessions = [];

  List<Video> get suggestedContent => _suggestedContent;
  List<Video> get trendingContent => _trendingContent;
  List<Video> get rainAndStormContent => _rainAndStormContent;
  List<Video> get meditationTypes => _meditationTypes;
  List<Video> get breathingSessions => _breathingSessions;

  final VideoService _videoService = VideoService();

  Future<void> fetchVideos() async {
    try {
      List<Video> allVideos = await _videoService.fetchVideos();

      // Assuming categories are in order of appearance
      _suggestedContent =
          allVideos.where((video) => video.category == 'Meditation').toList();
      _trendingContent =
          allVideos.where((video) => video.category == 'Movements').toList();
      _rainAndStormContent =
          allVideos.where((video) => video.category == 'Soundscape').toList();
      _meditationTypes =
          allVideos.where((video) => video.category == 'WorkRelief').toList();
      _breathingSessions =
          allVideos.where((video) => video.category == 'Breathing').toList();

      notifyListeners();
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }
}
