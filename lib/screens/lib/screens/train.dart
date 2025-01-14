import 'package:flutter/material.dart';
import 'package:railrelax/screens/lib/screens/apifetch.dart';
import 'compartment_page.dart';// Import the CompartmentPage
import 'package:provider/provider.dart';
import 'package:railrelax/screens/lib/l10n/app_localizations.dart';
import 'package:railrelax/screens/lib/providers/language_provider.dart';

class TrainPage extends StatelessWidget {
  const TrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Complete list of trains data
    final List<Map<String, String>> trains = [
      {
        'time': '07:16 PM',
        'destination': 'PAREL',
        'trainNo': '97418',
        'days': 'Not on Sunday',
        'route': 'THANE - PAREL',
        'status': 'Arriving MULUND, 6 min Late',
        'platform': '2'
      },
      {
        'time': '07:20 PM',
        'destination': 'CSMT',
        'trainNo': '97248',
        'days': 'DOMBIVLI - CSMT',
        'route': 'Between MUMBRA - KALVA',
        'status': '14 min Late',
        'platform': '2'
      },
      {
        'time': '07:24 PM',
        'destination': 'KURLA',
        'trainNo': '97132',
        'days': 'KYN PF1A',
        'route': 'KALYAN - KURLA',
        'status': 'Arriving DIVA, 16 min Late',
        'platform': '2'
      },
      {
        'time': '07:27 PM',
        'destination': 'CSMT',
        'trainNo': '97134',
        'days': 'KYN PF1A',
        'route': 'KALYAN - CSMT',
        'status': 'Crossed DIVA, 11 min Late',
        'platform': '2'
      },
      {
        'time': '07:31 PM',
        'destination': 'CSMT',
        'trainNo': '96516',
        'days': 'ASANGAON - CSMT',
        'route': 'Between KOPAR - DIVA',
        'status': '14 min Late',
        'platform': '2'
      },
      {
        'time': '07:36 PM',
        'destination': 'CSMT',
        'trainNo': '97420',
        'days': 'Not on Sunday',
        'route': 'THANE - CSMT',
        'status': 'On time',
        'platform': '2'
      },
      {
        'time': '07:40 PM',
        'destination': 'CSMT',
        'trainNo': '95238',
        'days': 'BADLAPUR - CSMT',
        'route': 'Crossed ULHAS NAGAR',
        'status': '13 min Late',
        'platform': '4'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Train Schedule'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: trains.length,
        itemBuilder: (context, index) {
          final train = trains[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              onTap: () {
                // Navigate to the CompartmentPage when a train is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FetchPage()
                  ),
                );
              },
              title: Row(
                children: [
                  Text(
                    train['time']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    train['destination']!,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                  SizedBox(width: 5),
                  Text(
                    train['days']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${train['trainNo']}: ${train['route']}'),
                  Text(
                    '[${train['status']}]',
                    style: TextStyle(
                      fontSize: 14,
                      color: train['status']!.contains('Late')
                          ? Colors.orange
                          : Colors.green,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PF',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    train['platform']!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
