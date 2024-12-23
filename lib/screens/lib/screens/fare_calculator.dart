import 'package:flutter/material.dart';

class FareCalculatorPage extends StatefulWidget {
  @override
  _FareCalculatorPageState createState() => _FareCalculatorPageState();
}

class _FareCalculatorPageState extends State<FareCalculatorPage> {
  final List<String> stations = [
    'Aamchi Mumbai',
    'Ambernath',
    'Andheri',
    'Aundh',
    'Badlapur',
    'Bandra',
    'Bhandup',
    'Bhayandar',
    'Borivali',
    'Byculla',
    'Chhatrapati Shivaji Maharaj Terminus',
    'Chinchwad',
    'Dadar',
    'Dahisar',
    'D N Nagar',
    'Ghatkopar',
    'Ghatkopar (W)',
    'Grant Road',
    'Jaslok Hospital',
    'Junction',
    'Kalyan',
    'Karjat',
    'Khar',
    'Kharghar',
    'Khandeshwar',
    'Kurla',
    'LBS Marg',
    'Lokmanya Tilak',
    'Malad',
    'Mankhurd',
    'Matunga',
    'Mira Road',
    'Mulund',
    'Mumbai Chhatrapati Shivaji Maharaj Airport',
    'Mumbai CST',
    'Mumbai Dadar',
    'Mumbai Lokmanya Tilak',
    'Nalasopara',
    'Navi Mumbai',
    'Nehru Planetarium',
    'Parel',
    'Panvel',
    'Powai',
    'Rabale',
    'Raigad',
    'Sion',
    'Sion Koliwada',
    'Thane',
    'Thakur Complex',
    'Uran',
    'Vashi',
    'Vile Parle',
    'Wadala',
    'Wadala (East)',
    'Wadala (West)',
    'Western Express Highway',
    'Yesvantpur',
    'Zirakpur',
  ]; // Complete list of Mumbai stations (A to Z)

  String? selectedFrom;
  String? selectedTo;
  double fare = 0.0;
  bool showCostTable = false; // Boolean to show/hide the cost table image

  // Sample fare structure (replace with your actual fare calculation logic)
  double calculateFare(String from, String to) {
    int indexFrom = stations.indexOf(from);
    int indexTo = stations.indexOf(to);

    // Example: fare is based on the number of stations between the two
    return (indexTo - indexFrom).abs() * 10.0; // Example: 10 currency units per station
  }

  void calculate() {
    if (selectedFrom != null && selectedTo != null && selectedFrom != selectedTo) {
      setState(() {
        fare = calculateFare(selectedFrom!, selectedTo!);
        showCostTable = true; // Show the cost table when both stations are selected
      });
    } else {
      setState(() {
        fare = 0.0; // Reset fare if inputs are invalid
        showCostTable = false; // Hide the cost table if inputs are invalid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fare Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Select From Station'),
              value: selectedFrom,
              items: stations.map((station) {
                return DropdownMenuItem(
                  value: station,
                  child: Text(station),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedFrom = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              hint: Text('Select To Station'),
              value: selectedTo,
              items: stations.map((station) {
                return DropdownMenuItem(
                  value: station,
                  child: Text(station),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedTo = value;
                });
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                calculate(); // Calculate fare and show the cost table
              },
              child: Text('Search Fare'),
            ),
            SizedBox(height: 30),
            // Text(
            //   'Fare: \$${fare.toStringAsFixed(2)}',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 30),

            // Show the cost table image if fare is calculated
            if (showCostTable)
              Container(
                width: 400, // Set width of the image
                height: 400, // Set height of the image
                child: Image.asset('assets/fare.jpeg'), // Replace with the actual path of your image
              ),
          ],
        ),
      ),
    );
  }
}
