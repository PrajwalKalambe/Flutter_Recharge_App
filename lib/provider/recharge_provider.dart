import 'package:flutter/material.dart';

class RechargeProvider with ChangeNotifier {
  // Add any state variables or methods needed
  // For example, fetching recharge plans from API

  List<Map<String, String>> _plans = [
    {'name': '₹199 - 28 Days, 1.5GB/day', 'price': '199'},
    {'name': '₹249 - 28 Days, 2GB/day', 'price': '249'},
    // Add more plans or fetch from backend
  ];

  List<Map<String, String>> get plans => _plans;

  // Implement methods to fetch and update plans if needed
}
