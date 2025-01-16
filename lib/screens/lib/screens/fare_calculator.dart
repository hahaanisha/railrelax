import 'package:flutter/material.dart';

class FareCalculator extends StatefulWidget {
  @override
  _FareCalculatorState createState() => _FareCalculatorState();
}

class _FareCalculatorState extends State<FareCalculator> {
  String selectedSource = '';
  String selectedDestination = '';
  String selectedLine = 'Western';
  String ticketType = 'ordinary';
  String ticketClass = 'second';
  int adultCount = 1;
  int childCount = 0;
  double calculatedFare = 0;

  // Define train lines for easier filtering
  final Map<String, List<String>> trainLines = {
    'Western': [
      'Churchgate',
      'Marine Lines',
      'Charni Road',
      'Grant Road',
      'Mumbai Central',
      'Mahalaxmi',
      'Lower Parel',
      'Elphinstone Road',
      'Dadar Western',
      'Matunga Road',
      'Mahim Junction',
      'Bandra',
      'Khar Road',
      'Santacruz',
      'Vile Parle',
      'Andheri',
      'Jogeshwari',
      'Ram Mandir',
      'Goregaon',
      'Malad',
      'Kandivali',
      'Borivali',
      'Dahisar',
      'Mira Road',
      'Bhayandar',
      'Naigaon',
      'Vasai Road',
      'Nalasopara',
      'Virar',
    ],
    'Central': [
      'CSMT',
      'Masjid',
      'Sandhurst Road',
      'Byculla',
      'Chinchpokli',
      'Currey Road',
      'Parel',
      'Dadar Central',
      'Matunga',
      'Sion',
      'Kurla',
      'Vidyavihar',
      'Ghatkopar',
      'Vikhroli',
      'Kanjurmarg',
      'Bhandup',
      'Nahur',
      'Mulund',
      'Thane',
      'Kalwa',
      'Mumbra',
      'Diva Junction',
      'Dombivli',
      'Kalyan',
      'Ulhasnagar',
      'Ambernath',
      'Badlapur',
      'Karjat',
      'Kasara',
    ],
    'Harbour': [
      'CSMT',
      'Masjid',
      'Sandhurst Road',
      'Dockyard Road',
      'Reay Road',
      'Cotton Green',
      'Sewri',
      'Wadala Road',
      'GTB Nagar',
      'Chunabhatti',
      'Kurla Harbour',
      'Tilak Nagar',
      'Chembur',
      'Govandi',
      'Mankhurd',
      'Vashi',
      'Sanpada',
      'Juinagar',
      'Nerul',
      'Seawoods-Darave',
      'CBD Belapur',
      'Kharghar',
      'Mansarovar',
      'Khandeshwar',
      'Panvel',
    ],
    'Trans-Harbour': [
      'Thane',
      'Airoli',
      'Rabale',
      'Ghansoli',
      'Kopar Khairane',
      'Turbhe',
      'Juinagar',
      'Nerul',
      'Seawoods-Darave',
      'CBD Belapur',
      'Kharghar',
      'Mansarovar',
      'Khandeshwar',
      'Panvel',
    ],
  };

  // Base fare matrix (in rupees) for second class
  final Map<String, double> baseFareMatrix = {
    '1-10': 5,    // Base fare for distances 1-10 km
    '11-20': 10,   // Base fare for distances 11-20 km
    '21-30': 15,   // Base fare for distances 21-30 km
    '31-40': 20,   // Base fare for distances 31-40 km
    '41-50': 25,   // Base fare for distances 41-50 km
    '51-100': 30,  // Base fare for distances 51-100 km
  };

  // Helper function to determine the fare range
  String getFareRange(double distance) {
    if (distance <= 10) return '1-10';
    if (distance <= 20) return '11-20';
    if (distance <= 30) return '21-30';
    if (distance <= 40) return '31-40';
    if (distance <= 50) return '41-50';
    return '51-100';
  }

  double calculateFare() {
    double distance = getDistance(selectedSource, selectedDestination);

    // Get base fare using the new range-based system
    String fareRange = getFareRange(distance);
    double baseFare = baseFareMatrix[fareRange] ?? baseFareMatrix['1-10']!;

    // Apply multipliers based on ticket type and class
    double finalFare = baseFare;

    if (ticketClass == 'first') {
      finalFare *= 4; // First class multiplier
    }

    switch (ticketType) {
      case 'return':
        finalFare *= 2;
        break;
      case 'monthly':
      // Monthly pass calculation with 20% discount
        finalFare = (finalFare * 30) * 0.8;
        break;
      case 'quarterly':
      // Quarterly pass calculation with 25% discount
        finalFare = (finalFare * 90) * 0.75;
        break;
    }

    // Calculate for multiple passengers
    finalFare = (finalFare * adultCount) + (finalFare * 0.5 * childCount);

    return finalFare;
  }

  // Distance calculation based on station indices (can be enhanced with actual distances)
  double getDistance(String source, String destination) {
    if (source.isEmpty || destination.isEmpty) return 0;

    int sourceIndex = trainLines[selectedLine]!.indexOf(source);
    int destIndex = trainLines[selectedLine]!.indexOf(destination);
    return (sourceIndex - destIndex).abs() * 2.0; // Approximate distance calculation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fare Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Line Selection
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Line',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedLine,
                  items: trainLines.keys.map((line) {
                    return DropdownMenuItem(
                      value: line,
                      child: Text('$line Line'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLine = value!;
                      selectedSource = '';
                      selectedDestination = '';
                    });
                  },
                ),
              ),
            ),

            // Station Selection
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'From Station',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedSource.isEmpty ? null : selectedSource,
                      items: trainLines[selectedLine]?.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSource = value!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'To Station',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedDestination.isEmpty ? null : selectedDestination,
                      items: trainLines[selectedLine]?.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDestination = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Ticket Options
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
                        DropdownMenuItem(value: 'ordinary', child: Text('Single Journey')),
                        DropdownMenuItem(value: 'return', child: Text('Return Journey')),
                        DropdownMenuItem(value: 'monthly', child: Text('Monthly Pass')),
                        DropdownMenuItem(value: 'quarterly', child: Text('Quarterly Pass')),
                      ],
                      onChanged: (value) => setState(() => ticketType = value!),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Class',
                        border: OutlineInputBorder(),
                      ),
                      value: ticketClass,
                      items: [
                        DropdownMenuItem(value: 'second', child: Text('Second Class')),
                        DropdownMenuItem(value: 'first', child: Text('First Class')),
                      ],
                      onChanged: (value) => setState(() => ticketClass = value!),
                    ),
                  ],
                ),
              ),
            ),

            // Passenger Count
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Adult (Full Ticket)'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (adultCount > 1) {
                                  setState(() => adultCount--);
                                }
                              },
                            ),
                            Text('$adultCount'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                if (adultCount < 4) {
                                  setState(() => adultCount++);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Child (Half Ticket)'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (childCount > 0) {
                                  setState(() => childCount--);
                                }
                              },
                            ),
                            Text('$childCount'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                if (childCount < 2) {
                                  setState(() => childCount++);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                if (selectedSource.isNotEmpty && selectedDestination.isNotEmpty) {
                  setState(() {
                    calculatedFare = calculateFare();
                  });
                }
              },
              child: Text(
                'Calculate Fare',
                style: TextStyle(fontSize: 18),
              ),
            ),

            if (calculatedFare > 0) ...[
              SizedBox(height: 24),
              Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Fare',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '₹${calculatedFare.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
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