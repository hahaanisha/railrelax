import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EnquiriesPage extends StatelessWidget {
  final List<Map<String, String>> Enquiries = [
    {
      "title": "M.T.D.C.",
      "contact": "022-22024482,022-22024522",
    },
    {
      "title": "Traffic Police Control Room",
      "contact": "022-24937755,022-24939717,022-24937747,+91 8454999999,+91 8448448960",
    },
    {
      "title": "Highway Safety Patrol State Traffic Control Room",
      "contact": "022-22626655",
    },
  ];

  EnquiriesPage({super.key});

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
        title: const Text('Tourist Enquiries'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: Enquiries.length,
        itemBuilder: (context, index) {
          final contact = Enquiries[index]; // Get the current contact
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
