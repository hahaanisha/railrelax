import 'package:flutter/material.dart';

class FareCalculator with ChangeNotifier {
  static double calculateFare({
    required double distance,
    required String ticketClass,
    required String ticketType,
  }) {
    // Base fares for different distance ranges
    final fareSlabs = {
      '1-10': 5,   // Distance range 1-10 km: ₹5
      '11-20': 10, // Distance range 11-20 km: ₹15
      '21-30': 15, // Distance range 21-30 km: ₹20
      '31-40': 20, // Distance range 31-40 km: ₹25
      '41-50': 25, // Distance range 41-50 km: ₹30
      '51-60': 30,
      '61-70': 35,

    };

    // Determine the base fare for the distance
    double baseFare = 0; // Default fare if no range matches
    for (var entry in fareSlabs.entries) {
      // Parse the range (e.g., "1-10" -> start: 1, end: 10)
      var range = entry.key.split('-');
      int start = int.parse(range[0]);
      int end = int.parse(range[1]);

      // Check if the distance falls within this range
      if (distance >= start && distance <= end) {
        baseFare = entry.value.toDouble();
        break;
      }
    }

    // Apply class multiplier
    double classMultiplier = ticketClass == 'FIRST' ? 10 : 1;

    // Apply ticket type multiplier
    double typeMultiplier = 1;
    switch (ticketType) {
      case 'return':
        typeMultiplier = 2;
        break;
      case 'monthly':
        typeMultiplier = 30;
        break;
      case 'quarterly':
        typeMultiplier = 90;
        break;
    }

    // Calculate and return the total fare
    return baseFare * classMultiplier * typeMultiplier;
  }
}
