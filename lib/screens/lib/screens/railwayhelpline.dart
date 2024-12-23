import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // For copying to clipboard

class RailwayHelplinePage extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'Railway Helpline 1', 'number': '1234567890'},
    {'name': 'Railway Helpline 2', 'number': '0987654321'},
    {'name': 'Train Accident Helpline', 'number': '1800111321'},
    {'name': 'Railway Police', 'number': '1512'},
    {'name': 'General Inquiry', 'number': '139'},
    {'name': 'Women Safety Helpline', 'number': '182'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Railway Emergency Contacts'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                title: Text(
                  contact['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  contact['number']!,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.copy, color: Colors.blue),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: contact['number']!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Copied ${contact['number']} to clipboard'),
                      ),
                    );
                  },
                ),
                onTap: () {
                  _makePhoneCall(contact['number']!);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri); // Open the dialer with the number
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
