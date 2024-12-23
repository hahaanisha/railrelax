import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// Define a service to fetch the people count from the API
class APIService {
  static Future<List<int>> getCompartmentCounts(String trainNumber) async {
    final response = await http.get(
      Uri.parse('http://192.168.0.123:5000/get_compartment_counts'),
    );


    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<int>.from(data['compartment_counts']); // Adjust API response as needed
    } else {
      throw Exception('Failed to load compartment counts');
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RailRelax',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeopleCounter(trainNumber: '97248'), // Example train number
    );
  }
}

class PeopleCounter extends StatefulWidget {
  final String trainNumber;

  const PeopleCounter({super.key, required this.trainNumber});

  @override
  _PeopleCounterState createState() => _PeopleCounterState();
}

class _PeopleCounterState extends State<PeopleCounter> {
  List<int> personCounts = List.filled(12, 0); // Initially filled with 12 compartments, all zero
  bool isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchCompartmentData();
    // Periodically update the compartment counts
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchCompartmentData();
    });
  }

  Future<void> fetchCompartmentData() async {
    try {
      List<int> counts = await APIService.getCompartmentCounts(widget.trainNumber);
      setState(() {
        personCounts = counts;
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Function to determine the color of each compartment based on the person count
  Color getCompartmentColor(int count) {
    if (count < 5) {
      return Colors.green;
    } else if (count >= 5 && count < 7) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compartments for Train ${widget.trainNumber}'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Display 3 compartments per row
        ),
        itemCount: personCounts.length,
        itemBuilder: (context, index) {
          return Card(
            color: getCompartmentColor(personCounts[index]),
            child: Center(
              child: Text(
                'Compartment ${index + 1}\nCount: ${personCounts[index]}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
