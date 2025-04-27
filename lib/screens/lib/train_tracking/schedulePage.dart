import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:railrelax/screens/lib/train_tracking/trainDetails.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('trains');
  List<Map<String, String>> trains = [];

  @override
  void initState() {
    super.initState();
    _fetchTrains();
  }

  void _fetchTrains() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        List<Map<String, String>> loadedTrains = [];

        data.forEach((key, value) {
          loadedTrains.add({
            'trainNo': value['trainNo'],
            'time': value['time'],
            'status': value['status'],
          });
        });

        setState(() {
          trains = loadedTrains;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Train Schedule')),
      body: trains.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: trains.length,
        itemBuilder: (context, index) {
          final train = trains[index];
          return Card(
            child: ListTile(
              title: Text('Train No: ${train['trainNo']}'),
              subtitle: Text('Time: ${train['time']} | Status: ${train['status']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainDetailsPage(trainNo: train['trainNo']!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
