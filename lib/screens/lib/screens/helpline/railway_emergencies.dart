import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RailwayEmergenciesPage extends StatelessWidget {
  final List<Map<String, String>> railwayEmergencyContacts = [
    {
      "title": "RPF - Railway Protection Force",
      "description": "Theft, harassment, criminal incidents",
      "contact": "182",
    },
    {
      "title": "Emergency Call - Mumbai Railway Police",
      "description": "Grievances/Better Services (24 x 7)",
      "contact": "1512",
    },
    {
      "title": "WhatsApp - Mumbai Railway Police",
      "description": "Available for quick assistance via WhatsApp messaging.",
      "contact": "9594899991, 8425099991",
    },
    {
      "title": "Control Room - Mumbai Railway Police",
      "description": "24/7 assistance for emergencies and support.",
      "contact": "022-23759201, 022-23759283",
    },
    {
      "title": "Customer Helpline",
      "description": "Food, catering, coach maintenance, medical emergency, linen",
      "contact": "138",
    },
  ];

  RailwayEmergenciesPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Railway Emergencies'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: railwayEmergencyContacts.length,
        itemBuilder: (context, index) {
          final contact = railwayEmergencyContacts[index]; // Get the current contact
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                title: Text(
                  contact['title'] ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                subtitle: contact['description'] != null
                    ? Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    contact['description']!,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                      height: 1.3,
                    ),
                  ),
                )
                    : null,
                trailing: IconButton(
                  icon: Icon(
                    Icons.call,
                    color: Colors.blue.shade400,
                    size: 22,
                  ),
                  onPressed: () {
                    final numbers = contact['contact']!.split(',');
                    if (numbers.length == 1) {
                      _makePhoneCall(numbers[0].trim());
                    } else {
                      _showNumberSelectionDialog(context, numbers);
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNumberSelectionDialog(BuildContext context, List<String> numbers) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select a Number"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: numbers
              .map(
                (number) => ListTile(
              title: Text(number.trim()),
              trailing: const Icon(Icons.call, color: Colors.green),
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall(number.trim());
              },
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}