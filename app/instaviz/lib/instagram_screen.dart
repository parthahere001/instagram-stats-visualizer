import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InstagramScreenState createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> {
  String username = '';
  Map<String, dynamic> instagramData = {};

  Future<void> fetchInstagramData(String username) async {
    final response = await http.get(Uri.parse('http://your-django-server/instagram-data/$username/'));
  
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        instagramData = data;
      });
    } else {
      throw Exception('Failed to fetch Instagram data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insaviz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Instagram Username',
              ),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                fetchInstagramData(username);
              },
              child: const Text('Fetch Data'),
            ),
            const SizedBox(height: 16.0),
            if (instagramData.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: ${instagramData['username']}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Followers: ${instagramData['followers']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Following: ${instagramData['following']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Comments: ${instagramData['comments']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    'Likes: ${instagramData['likes']}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  if (instagramData.containsKey('followers_diff'))
                    Text(
                      'Followers Growth: ${instagramData['followers_diff']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  if (instagramData.containsKey('following_diff'))
                    Text(
                      'Following Growth: ${instagramData['following_diff']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  if (instagramData.containsKey('comments_diff'))
                    Text(
                      'Comments Growth: ${instagramData['comments_diff']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  if (instagramData.containsKey('likes_diff'))
                    Text(
                      'Likes Growth: ${instagramData['likes_diff']}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  const SizedBox(height: 16.0),
                  // Add charts or any other visualization widgets here
                ],
              ),
          ],
        ),
      ),
    );
  }
}
