import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TrainDetailsPage extends StatefulWidget {
  final String trainNo;
  TrainDetailsPage({required this.trainNo});

  @override
  _TrainDetailsPageState createState() => _TrainDetailsPageState();
}

class _TrainDetailsPageState extends State<TrainDetailsPage> {
  final DatabaseReference _coachesRef = FirebaseDatabase.instance.ref().child('coaches');
  int coachCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchCoachCount();
  }

  void _fetchCoachCount() async {
    final snapshot = await _coachesRef.child(widget.trainNo).get();

    if (snapshot.exists) {
      setState(() {
        coachCount = snapshot.children.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Train ${widget.trainNo} Coaches')),
      body: coachCount == 0
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: coachCount,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Coach ${index + 1}'),
              subtitle: Text('Count: '),
            ),
          );
        },
      ),
    );
  }
}
