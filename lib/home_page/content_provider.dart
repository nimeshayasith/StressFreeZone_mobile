import 'package:flutter/material.dart';

enum MediaType { audio, video }

class Content {
  final String title;
  final String imageUrl;
  final String mediaUrl;
  final MediaType mediaType;
  final String duration;
  final double rating;

  Content(
      {required this.title,
      required this.duration,
      required this.imageUrl,
      required this.mediaUrl,
      required this.rating,
      required this.mediaType});
}

class ContentProvider with ChangeNotifier {
  final List<Content> _suggestedContent = [
    Content(
      title: 'Relaxing Meditation',
      imageUrl: 'https://exapmple.com/meditation1.jpg',
      duration: '20 min',
      rating: 4.5,
      mediaUrl: '',
      mediaType: MediaType.audio,
    ),
    Content(
      title: 'Deep Breathing',
      imageUrl: 'https://example.com/breathing1.jpg',
      duration: '15 min',
      rating: 4.8,
      mediaUrl: '',
      mediaType: MediaType.video,
    ),
  ];

  final List<Content> _trendingContent = [
    Content(
      title: 'Stress Relief',
      imageUrl: 'https://example.com/stress_relief1.jpg',
      duration: '30 min',
      rating: 4.9,
      mediaUrl: '',
      mediaType: MediaType.video,
    ),
    Content(
      title: 'Mindful Walk',
      imageUrl: 'https://example.com/mindful_walk1.jpg',
      duration: '25 min',
      rating: 4.6,
      mediaUrl: '',
      mediaType: MediaType.audio,
    ),
  ];

  final List<Content> _rainAndStormContent = [
    Content(
      title: 'Rain on Leaves',
      imageUrl: 'https://example.com/rain_leaves.jpg',
      duration: '60 min',
      rating: 5.0,
      mediaUrl: '',
      mediaType: MediaType.audio,
    ),
    Content(
      title: 'Thunderstorm',
      imageUrl: 'https://example.com/thunderstorm.jpg',
      duration: '45 min',
      rating: 4.7,
      mediaUrl: '',
      mediaType: MediaType.video,
    ),
  ];

  final List<Content> _meditationTypes = [
    Content(
      title: 'Mindfulness Meditation',
      imageUrl: 'https://example.com/mindfulness.jpg',
      duration: '10 min',
      rating: 4.5,
      mediaUrl: '',
      mediaType: MediaType.video,
    ),
    Content(
      title: 'Loving-Kindness Meditation',
      imageUrl: 'https://example.com?loving_kindness.jpg',
      duration: '20 min',
      rating: 4.4,
      mediaUrl: '',
      mediaType: MediaType.audio,
    ),
  ];

  final List<Content> _breathingSessions = [
    Content(
      title: '4-7-8 Breathing',
      imageUrl: 'https://example.com/478_breathing.jpg',
      duration: '5 min',
      rating: 4.8,
      mediaUrl: '',
      mediaType: MediaType.video,
    ),
    Content(
      title: 'Box Breathing',
      imageUrl: 'https://example.com/box_breathing.jpg',
      duration: '6 min',
      rating: 4.6,
      mediaUrl: '',
      mediaType: MediaType.video,
    ),
  ];

  List<Content> get suggestedContent => _suggestedContent;
  List<Content> get trendingContent => _trendingContent;
  List<Content> get rainAndStormContent => _rainAndStormContent;
  List<Content> get meditationTypes => _meditationTypes;
  List<Content> get breathingSessions => _breathingSessions;

  void addSuggestedContent(Content content) {
    _trendingContent.add(content);
    notifyListeners();
  }
}
