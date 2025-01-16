import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/providers/fare_provider.dart';

class FareCalculatorScreen extends StatefulWidget {
  @override
  _FareCalculatorScreenState createState() => _FareCalculatorScreenState();
}

class _FareCalculatorScreenState extends State<FareCalculatorScreen> {
  String selectedSource = '';
  String selectedDestination = '';
  String ticketType = 'single';
  String ticketClass = 'SECOND';
  double calculatedFare = 0;

  final Map<String, Map<String, double>> stationDistances = {
    'Churchgate': {
      'Marine Lines': 1.2,
      'Charni Road': 2.4,
      'Grant Road': 4.1,
    },
    'Marine Lines': {
      'Charni Road': 1.2,
      'Grant Road': 2.9,
    },
    // Add more station distances
  };

  void calculateFare() {
    if (selectedSource.isEmpty || selectedDestination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both stations')),
      );
      return;
    }

    double distance = stationDistances[selectedSource]?[selectedDestination] ?? 0;

    setState(() {
      calculatedFare = FareCalculator.calculateFare(
        distance: distance,
        ticketClass: ticketClass,
        ticketType: ticketType,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Fare Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Source Station',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedSource.isEmpty ? null : selectedSource,
                      hint: Text('Select Source Station'),
                      items: stationDistances.keys.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSource = value ?? '';
                          selectedDestination = '';
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Destination Station',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedDestination.isEmpty ? null : selectedDestination,
                      hint: Text('Select Destination Station'),
                      items: selectedSource.isEmpty
                          ? []
                          : stationDistances[selectedSource]?.keys.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDestination = value ?? '';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Ticket Type',
                        border: OutlineInputBorder(),
                      ),
                      value: ticketType,
                      items: [
                        DropdownMenuItem(value: 'single', child: Text('Single Journey')),
                        DropdownMenuItem(value: 'return', child: Text('Return Journey')),
                        DropdownMenuItem(value: 'monthly', child: Text('Monthly Pass')),
                        DropdownMenuItem(value: 'quarterly', child: Text('Quarterly Pass')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          ticketType = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(),
                      ),
                      value: ticketClass,
                      items: [
                        DropdownMenuItem(value: 'FIRST', child: Text('First Class')),
                        DropdownMenuItem(value: 'SECOND', child: Text('Second Class')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          ticketClass = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: calculateFare,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Calculate Fare'),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (calculatedFare > 0) ...[
              SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Fare Amount',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '₹${calculatedFare.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}