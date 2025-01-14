import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class HospitalDirectoryPage extends StatefulWidget {
  @override
  _HospitalDirectoryPageState createState() => _HospitalDirectoryPageState();
}

class _HospitalDirectoryPageState extends State<HospitalDirectoryPage> {
  List<Map<String, dynamic>> hospitals = [];
  List<Map<String, dynamic>> filteredHospitals = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadHospitalData();
    searchController.addListener(() {
      filterHospitals(searchController.text);
    });
  }

  Future<void> loadHospitalData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
      await rootBundle.loadString('assets/hospitals.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        hospitals = List<Map<String, dynamic>>.from(jsonData['hospitals']);
        filteredHospitals = hospitals; // Initially, show all hospitals
        isLoading = false;
      });
    } catch (e) {
      print('Error loading hospital data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterHospitals(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredHospitals = hospitals;
      });
    } else {
      setState(() {
        filteredHospitals = hospitals.where((hospital) {
          final name = hospital['name']?.toLowerCase() ?? '';
          final type = hospital['type']?.toLowerCase() ?? '';
          final address = hospital['address']?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) ||
              type.contains(query.toLowerCase()) ||
              address.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Medical Help'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Emergency Numbers Section
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red[100],
            child: Row(
              children: [
                Icon(Icons.emergency, color: Colors.red),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency Numbers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Ambulance: 108'),
                      Text('Emergency Helpline: 112'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search hospitals...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    filterHospitals(''); // Reset search
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Hospitals List
          Expanded(
            child: ListView.builder(
              itemCount: filteredHospitals.length,
              itemBuilder: (context, index) {
                final hospital = filteredHospitals[index];
                return Card(
                  margin:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ExpansionTile(
                    leading: Icon(Icons.local_hospital,
                        color: hospital['type']
                            .toString()
                            .contains('Government')
                            ? Colors.green
                            : Colors.blue),
                    title: Text(
                      hospital['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(hospital['type']!),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address: ${hospital['address']}'),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.phone, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                      'Helpline: ${hospital['phone']}'),
                                ),
                                TextButton.icon(
                                  onPressed: () =>
                                      _makePhoneCall(hospital['phone']!),
                                  icon: Icon(Icons.call),
                                  label: Text('CALL'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.emergency,
                                    size: 16, color: Colors.red),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Emergency: ${hospital['emergencyNum']}',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () => _makePhoneCall(
                                      hospital['emergencyNum']!),
                                  icon: Icon(Icons.emergency),
                                  label: Text('EMERGENCY'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _makePhoneCall('108'),
        backgroundColor: Colors.red,
        child: Icon(Icons.emergency),
        tooltip: 'Call Emergency Services',
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch $launchUri: $e');
    }
  }
}
