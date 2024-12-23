import 'package:flutter/material.dart';
import 'people_counter_api.dart'; // Import the API service for fetching person count

class CompartmentPage extends StatefulWidget {
  final String trainNumber;

  // Constructor to accept trainNumber
  const CompartmentPage({Key? key, required this.trainNumber}) : super(key: key);

  @override
  _CompartmentPageState createState() => _CompartmentPageState();
}

class _CompartmentPageState extends State<CompartmentPage> {
  List<int> personCounts = List.filled(12, 0); // Initializing with default person counts
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCompartmentData(); // Fetch compartment data when the page loads
  }

  // Function to fetch person count for the compartments
  void fetchCompartmentData() async {
    try {
      List<int> counts = await APIService.getCompartmentCounts(widget.trainNumber); // Fetch from API using trainNumber
      setState(() {
        personCounts = counts;
        isLoading = true;
      });
    } catch (e) {
      print(e);
    }
  }

  // Function to determine the color of the compartment based on person count
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
          : Column(
        children: [
          // WEST and EAST Labels at the top
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('WEST', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('EAST', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          // Compartments in a single vertical list (center-aligned)
          Expanded(
            child: ListView.builder(
              itemCount: personCounts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0), // Reduce vertical padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center align the compartments
                    children: [
                      // Compartment in the center of the screen
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4, // Reduce the width to make compartments smaller
                        height: 60.0, // Set a fixed height for the compartment
                        color: getCompartmentColor(personCounts[index]), // Get color based on person count
                        padding: const EdgeInsets.all(8.0), // Reduce padding
                        child: Center(
                          child: Text(
                            'C${index + 1}\nCount: ${personCounts[index]}', // Shorten compartment label
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14), // Adjust text size
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Footer Information
          Container(
            color: Colors.green,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'At KANJURMARG, 10 min late',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
