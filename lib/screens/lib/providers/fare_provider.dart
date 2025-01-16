import 'package:flutter/material.dart';

class FareCalculator with ChangeNotifier {
  static double calculateFare({
    required double distance,
    required String ticketClass,
    required String ticketType,
  }) {
    // Base fares for different distance slabs (in km)
    final fareSlabs = {
      10: 5,    // 0-1 km: ₹10
      3: 15,    // 1-3 km: ₹15
      5: 20,    // 3-5 km: ₹20
      10: 25,   // 5-10 km: ₹25
      15: 30,   // 10-15 km: ₹30
    };

    // Find applicable base fare
    double baseFare = 10; // Minimum fare
    for (var entry in fareSlabs.entries) {
      if (distance <= entry.key) {
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

    return baseFare * classMultiplier * typeMultiplier;
  }
}