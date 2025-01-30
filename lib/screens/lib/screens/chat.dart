import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

// Model classes
class Train {
  final String trainNumber;
  final String trainName;
  final List<String> stations;
  final Map<String, String> departureTimes;
  final Map<String, String> arrivalTimes;
  final Map<String, double> fares;

  Train({
    required this.trainNumber,
    required this.trainName,
    required this.stations,
    required this.departureTimes,
    required this.arrivalTimes,
    required this.fares,
  });
}

class RailwayBrain {
  List<Train> trains = [];

  Future<void> loadTrainData() async {
    try {
      final String rawData = await rootBundle.loadString('assets/train_chatbot - Sheet1.csv');
      List<List<dynamic>> csvData = const CsvToListConverter().convert(rawData);

      // Skip header row
      csvData.removeAt(0);

      for (var row in csvData) {
        trains.add(Train(
          trainNumber: row[0].toString(),
          trainName: row[1].toString(),
          stations: row[2].toString().split('|'),
          departureTimes: _parseTimeMap(row[3].toString()),
          arrivalTimes: _parseTimeMap(row[4].toString()),
          fares: _parseFareMap(row[5].toString()),
        ));
      }
    } catch (e) {
      print('Error loading CSV: $e');
    }
  }

  Map<String, String> _parseTimeMap(String data) {
    Map<String, String> timeMap = {};
    for (String pair in data.split('|')) {
      List<String> parts = pair.split(':');
      if (parts.length == 2) {
        timeMap[parts[0]] = parts[1];
      }
    }
    return timeMap;
  }

  Map<String, double> _parseFareMap(String data) {
    Map<String, double> fareMap = {};
    for (String pair in data.split('|')) {
      List<String> parts = pair.split(':');
      if (parts.length == 2) {
        fareMap[parts[0]] = double.tryParse(parts[1]) ?? 0.0;
      }
    }
    return fareMap;
  }

  String generateResponse(String query) {
    query = query.toLowerCase();

    // Train schedule query
    if (query.contains('schedule') || query.contains('time')) {
      return _handleScheduleQuery(query);
    }

    // Fare query
    if (query.contains('fare') || query.contains('price') || query.contains('cost')) {
      return _handleFareQuery(query);
    }

    // Train search between stations
    if (query.contains('trains between') || query.contains('trains from')) {
      return _handleTrainsBetweenQuery(query);
    }

    // Train information
    if (query.contains('train')) {
      return _handleTrainInfoQuery(query);
    }

    // Station information
    if (query.contains('station')) {
      return _handleStationQuery(query);
    }

    // Help message
    if (query.contains('help')) {
      return '''I can help you with:
1. Train schedules (e.g., "What's the schedule for train 12345?")
2. Fare information (e.g., "What's the fare from Mumbai to Delhi?")
3. Train search (e.g., "Show trains between Mumbai and Delhi")
4. Station information (e.g., "Which trains stop at Mumbai?")
5. Train information (e.g., "Tell me about train 12345")

Just ask me anything about trains!''';
    }

    return "I'm not sure about that. You can type 'help' to see what I can do!";
  }

  String _handleScheduleQuery(String query) {
    for (Train train in trains) {
      if (query.contains(train.trainNumber)) {
        StringBuilder schedule = StringBuilder();
        schedule.writeln('Schedule for ${train.trainName} (${train.trainNumber}):');

        for (String station in train.stations) {
          schedule.writeln('$station:');
          schedule.writeln('  Arrival: ${train.arrivalTimes[station] ?? 'N/A'}');
          schedule.writeln('  Departure: ${train.departureTimes[station] ?? 'N/A'}');
        }

        return schedule.toString();
      }
    }
    return "Please provide a valid train number for schedule information.";
  }

  String _handleFareQuery(String query) {
    for (Train train in trains) {
      if (query.contains(train.trainNumber)) {
        StringBuilder fares = StringBuilder();
        fares.writeln('Fares for ${train.trainName} (${train.trainNumber}):');

        train.fares.forEach((route, fare) {
          fares.writeln('$route: ₹$fare');
        });

        return fares.toString();
      }
    }
    return "Please provide a valid train number for fare information.";
  }

  String _handleTrainsBetweenQuery(String query) {
    String from = '', to = '';

    // Extract station names from query
    // This is a simple implementation - you might want to improve it
    List<String> words = query.split(' ');
    int fromIndex = words.indexOf('from');
    int toIndex = words.indexOf('to');

    if (fromIndex != -1 && toIndex != -1 && fromIndex < toIndex) {
      from = words[fromIndex + 1];
      to = words[toIndex + 1];

      List<Train> availableTrains = trains.where((train) {
        List<String> stations = train.stations;
        return stations.contains(from) && stations.contains(to);
      }).toList();

      if (availableTrains.isEmpty) {
        return "No direct trains found between $from and $to.";
      }

      StringBuilder result = StringBuilder();
      result.writeln('Trains between $from and $to:');

      for (Train train in availableTrains) {
        result.writeln('${train.trainNumber} - ${train.trainName}');
      }

      return result.toString();
    }

    return "Please specify both source and destination stations.";
  }

  String _handleTrainInfoQuery(String query) {
    for (Train train in trains) {
      if (query.contains(train.trainNumber)) {
        return '''Train Information:
Number: ${train.trainNumber}
Name: ${train.trainName}
Stops at: ${train.stations.join(', ')}''';
      }
    }
    return "Please provide a valid train number.";
  }

  String _handleStationQuery(String query) {
    String station = '';
    List<String> words = query.split(' ');
    int stationIndex = words.indexOf('station');

    if (stationIndex != -1 && stationIndex < words.length - 1) {
      station = words[stationIndex + 1];

      List<Train> trainsAtStation = trains.where((train) =>
          train.stations.contains(station)
      ).toList();

      if (trainsAtStation.isEmpty) {
        return "No trains found stopping at $station.";
      }

      StringBuilder result = StringBuilder();
      result.writeln('Trains stopping at $station:');

      for (Train train in trainsAtStation) {
        result.writeln('${train.trainNumber} - ${train.trainName}');
        String arrivalTime = train.arrivalTimes[station] ?? 'N/A';
        String departureTime = train.departureTimes[station] ?? 'N/A';
        result.writeln('  Arrival: $arrivalTime');
        result.writeln('  Departure: $departureTime');
      }

      return result.toString();
    }

    return "Please specify a station name.";
  }
}

class StringBuilder {
  final StringBuffer _buffer = StringBuffer();

  void writeln(String line) {
    _buffer.writeln(line);
  }

  @override
  String toString() => _buffer.toString();
}

// Chat UI implementation
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final RailwayBrain _railwayBrain = RailwayBrain();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _railwayBrain.loadTrainData();
    setState(() {
      _isLoading = false;
      _messages.add(ChatMessage(
        text: "Hello! I'm your railway assistant. How can I help you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatMessage(
          text: _railwayBrain.generateResponse(text),
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Railway Assistant'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Divider(height: 1.0),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
        message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Ask about trains, schedules, or fares...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                contentPadding: EdgeInsets.all(12.0),
              ),
              onSubmitted: _handleSubmitted,
            ),
          ),
          SizedBox(width: 8.0),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _handleSubmitted(_textController.text);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}