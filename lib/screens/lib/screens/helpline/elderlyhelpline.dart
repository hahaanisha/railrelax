import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show Clipboard, rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class ElderlyHelplinePage extends StatefulWidget {
  @override
  _ElderlyHelplinePageState createState() => _ElderlyHelplinePageState();
}

class _ElderlyHelplinePageState extends State<ElderlyHelplinePage> {
  List<Map<String, dynamic>> helplines = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHelplineData();
  }

  Future<void> loadHelplineData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
      await rootBundle.loadString('assets/elderly_helplines.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        helplines = List<Map<String, dynamic>>.from(jsonData['helplines']);
        isLoading = false;
      });
    } catch (e) {
      print('Error loading helpline data: $e');
      setState(() {
        isLoading = false;
      });
    }
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


  Future<void> _copyToClipboard(String phoneNumber) async {
    await Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phone number copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Senior Citizen Helpline'),
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
                      Text('Elderline: 14567'),
                      Text('Police: 112'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Helplines List
          Expanded(
            child: ListView.builder(
              itemCount: helplines.length,
              itemBuilder: (context, index) {
                final helpline = helplines[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(

                    title: Text(
                      helpline['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(helpline['type']!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.call, color: Colors.blue),
                          onPressed: () => _makePhoneCall(helpline['phone']!),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy, color: Colors.blue),
                          onPressed: () => _copyToClipboard(helpline['phone']!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
