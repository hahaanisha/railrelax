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
    if (indexFrom == -1 || indexTo == -1) {
      throw Exception('Invalid station selected');
    }

    return (indexTo - indexFrom).abs() * 10.0;
  }

  void calculate() {
    if (selectedFrom == null || selectedTo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both stations'))
      );
      return;
    }

    if (selectedFrom == selectedTo) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select different stations'))
      );
      return;
    }

    setState(() {
      try {
        fare = calculateFare(selectedFrom!, selectedTo!);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error calculating fare'))
        );
        fare = 0.0;
      }
    });
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
            // Wrap dropdown in container with width constraint
            Container(
              width: double.infinity, // Takes full width
              child: DropdownButton<String>(
                hint: Text('Select From Station'),
                value: selectedFrom,
                isExpanded: true, // Important! Makes dropdown fit in container
                items: stations.map((station) {
                  return DropdownMenuItem(
                    value: station,
                    child: Text(
                      station,
                      overflow: TextOverflow.ellipsis, // Handles text overflow
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedFrom = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            // Same for second dropdown
            Container(
              width: double.infinity,
              child: DropdownButton<String>(
                hint: Text('Select To Station'),
                value: selectedTo,
                isExpanded: true,
                items: stations.map((station) {
                  return DropdownMenuItem(
                    value: station,
                    child: Text(
                      station,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTo = value;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                calculate(); // Calculate fare and show the cost table
              },
              child: Text('Search Fare'),
            ),
            SizedBox(height: 15),
            // Text(
            //   'Fare: \$${fare.toStringAsFixed(2)}',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 15),

            // Show the cost table image if fare is calculated
            if (fare > 0)
              AspectRatio(
                aspectRatio: 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'assets/fare.jpeg',
                    errorBuilder: (context, error, stackTrace) {
                      return Center(child: Text('Unable to load fare table'));
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
