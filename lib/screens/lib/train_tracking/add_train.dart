import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddTrainPage extends StatefulWidget {
  @override
  _AddTrainPageState createState() => _AddTrainPageState();
}

class _AddTrainPageState extends State<AddTrainPage> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _trainNoController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _coachController = TextEditingController();

  void _addTrain() async {
    if (_formKey.currentState!.validate()) {
      String trainNo = _trainNoController.text.trim();
      int coachCount = int.tryParse(_coachController.text.trim()) ?? 0;

      try {
        // Add train details to 'trains' database
        await _dbRef.child('trains').child(trainNo).set({
          'time': _timeController.text.trim(),
          'destination': _destinationController.text.trim(),
          'trainNo': trainNo,
          'days': _daysController.text.trim(),
          'route': _routeController.text.trim(),
          'status': _statusController.text.trim(),
          'platform': _platformController.text.trim(),
          'coaches': coachCount.toString(),
        });

        // Add coach details to 'coaches' database
        DatabaseReference coachesRef = _dbRef.child('coaches').child(trainNo);
        for (int i = 1; i <= coachCount; i++) {
          await coachesRef.child(i.toString()).set({'count': 0});
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Train and coaches added successfully!')),
        );
        _formKey.currentState!.reset();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Train Details')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                  validator: (value) => value!.isEmpty ? 'Enter time' : null,
                ),
                TextFormField(
                  controller: _destinationController,
                  decoration: InputDecoration(labelText: 'Destination'),
                  validator: (value) => value!.isEmpty ? 'Enter destination' : null,
                ),
                TextFormField(
                  controller: _trainNoController,
                  decoration: InputDecoration(labelText: 'Train No'),
                  validator: (value) => value!.isEmpty ? 'Enter train number' : null,
                ),
                TextFormField(
                  controller: _daysController,
                  decoration: InputDecoration(labelText: 'Days'),
                  validator: (value) => value!.isEmpty ? 'Enter days' : null,
                ),
                TextFormField(
                  controller: _routeController,
                  decoration: InputDecoration(labelText: 'Route'),
                  validator: (value) => value!.isEmpty ? 'Enter route' : null,
                ),
                TextFormField(
                  controller: _statusController,
                  decoration: InputDecoration(labelText: 'Status'),
                  validator: (value) => value!.isEmpty ? 'Enter status' : null,
                ),
                TextFormField(
                  controller: _platformController,
                  decoration: InputDecoration(labelText: 'Platform'),
                  validator: (value) => value!.isEmpty ? 'Enter platform' : null,
                ),
                TextFormField(
                  controller: _coachController,
                  decoration: InputDecoration(labelText: 'Coaches'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter number of coaches' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addTrain,
                  child: Text('Add Train'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
