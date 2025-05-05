// lib/services/video_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video.dart';

class VideoService {
  // final String cloudName = Constants.CLOUDINARY_CLOUD_NAME;
  // final String apiKey =
  //     Constants.CLOUDINARY_API_KEY; // Replace with your Cloudinary API key
  // final String apiSecret = Constants
  //     .CLOUDINARY_API_SECRET; // Replace with your Cloudinary API secret

  Future<List<Video>> fetchVideos() async {
    // final String url1 = 'https://stressfreezone-web.onrender.com/api/videos/Meditation';
    // final String url2 = 'https://stressfreezone-web.onrender.com/api/videos/Movements';
    // final String url3 = 'https://stressfreezone-web.onrender.com/api/videos/Soundscape';
    // final String url4 = 'https://stressfreezone-web.onrender.com/api/videos/WorkRelief';
    // //final String url5 = 'https://stressfreezone-web.onrender.com/api/videos/Meditation';
    final List<String> categories = [
      'Meditation',
      'Movements',
      'Soundscape',
      'WorkRelief',
      'LearnMore'
    ];
    List<Video> allVideos = [];

    try {
      for (String category in categories) {
        final String url =
            'https://stressfreezone-web.onrender.com/api/videos/$category';
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final List<dynamic> responseData = jsonDecode(response.body);
          List<Video> categoryVideos =
              responseData.map((data) => Video.fromMap(data)).toList();
          allVideos.addAll(categoryVideos);
        } else {
          throw Exception('Failed to load videos for category $category');
        }
      }
      return allVideos;
    } catch (e) {
      throw Exception('Error fetching videos: $e');
    }
    // final Map<String, String> headers = {
    //   'Authorization':
    //       'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
    //   'Content-Type': 'application/json',
    // };

    // final Map<String, dynamic> body = {
    //   'expression': 'resource_type:video',
    //   'max_results': 10,
    // };

    // try {
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: headers,
    //     body: jsonEncode(body),
    //   );

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> responseData = jsonDecode(response.body);
    //     final List<dynamic> resources = responseData['resources'];

    //     return resources.map((resource) {
    //       // Assign categories manually (or fetch from API if available)
    //       final categories = [
    //         'Meditation',
    //         'Movements',
    //         'Soundscape',
    //         'WorkRelief',
    //         'LearnMore'
    //       ];
    //       final randomCategory =
    //           categories[(resource['public_id'].hashCode % categories.length)];

    //       return Video(
    //         id: resource['public_id'],
    //         title: resource[
    //             'public_id'], // Use public_id as title (or modify as needed)
    //         description: '', // Add description if available
    //         url: resource['secure_url'],
    //         thumbnail: resource['secure_url'].replaceAll('.mp4', '.jpg'),
    //         category: randomCategory, // Assign a random category
    //       );
    //     }).toList();
    //   } else {
    //     throw Exception('Failed to fetch videos: ${response.statusCode}');
    //   }
    // } catch (e) {
    //   throw Exception('Error fetching videos: $e');
    // }
  }
}
