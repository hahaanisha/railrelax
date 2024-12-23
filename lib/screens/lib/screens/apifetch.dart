// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//
// void main() {
//   runApp(const MyApp());
// }

// class FetchPage extends StatelessWidget {
//   const FetchPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'RAILRELAX',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// HomePage
class FetchPage extends StatefulWidget {
  const FetchPage({super.key});

  @override
  State<FetchPage> createState() => _FetchPageState();
}

class _FetchPageState extends State<FetchPage> {
  int peopleCount = 0;
  String cameraId = 'R1001';
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchCount();
    // Set up periodic polling every 5 seconds
    Future.delayed(Duration.zero, () {
      _startPeriodicFetch();
    });
  }

  void _startPeriodicFetch() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      if (!mounted) return false;
      await fetchCount();
      return true;
    });
  }

  Future<void> fetchCount() async {
    try {
      setState(() {
        isLoading = true;
        error = '';
      });

      final response = await http.get(
        Uri.parse('http://192.168.254.92:5000/get_count'),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timed out');
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          peopleCount = data['people_count'];
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
        isLoading = false;
      });
    }
  }

  void _navigateToDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          count: peopleCount,
          cameraId: cameraId,
          videoUrl: 'http://192.168.254.92:5000/video_feed',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'RAILRELAX',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchCount,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error.isNotEmpty
            ? Center(child: Text(error))
            : GestureDetector(
          onTap: _navigateToDetailsPage,
          child: Container(
            height: size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade300,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        cameraId,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: size.width * 0.1),
                      for (int i = 0; i < peopleCount; i++)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            Icons.directions_walk,
                            color: Colors.blue,
                          ),
                        ),
                      const Spacer(),
                      Text(
                        'Count: $peopleCount',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// DetailsPage
class DetailsPage extends StatelessWidget {
  final int count;
  final String cameraId;
  final String videoUrl;

  const DetailsPage({
    Key? key,
    required this.count,
    required this.cameraId,
    required this.videoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Details',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              color: Colors.black,
              child: Image.network(
                videoUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Error loading video feed',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Camera ID: $cameraId',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'People Count: $count',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < count; i++)
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.directions_walk,
                                size: 32,
                                color: Colors.blue,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}