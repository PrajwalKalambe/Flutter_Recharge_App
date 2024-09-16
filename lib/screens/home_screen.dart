import 'package:flutter/material.dart';
import 'recharge_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedOperator = 'Select Operator';
  String _mobileNumber = '';
  String _selectedPlan = '';

  final List<String> _operators = ['Airtel', 'Jio', 'Vodafone', 'BSNL'];
  final List<Map<String, String>> _plans = [
    {'name': '₹199 - 28 Days, 1.5GB/day', 'price': '199'},
    {'name': '₹249 - 28 Days, 2GB/day', 'price': '249'},
    // Add more plans or fetch dynamically from API
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Recharge'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Mobile Number Input
            TextField(
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _mobileNumber = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Operator Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Operator',
                border: OutlineInputBorder(),
              ),
              value: _selectedOperator == 'Select Operator' ? null : _selectedOperator,
              items: _operators
                  .map((operator) => DropdownMenuItem(
                        value: operator,
                        child: Text(operator),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOperator = value!;
                });
              },
              validator: (value) => value == null ? 'Please select an operator' : null,
            ),
            SizedBox(height: 20),

            // Plans List
            Expanded(
              child: ListView.builder(
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text(_plans[index]['name']!),
                    value: _plans[index]['price']!,
                    groupValue: _selectedPlan,
                    onChanged: (value) {
                      setState(() {
                        _selectedPlan = value!;
                      });
                    },
                  );
                },
              ),
            ),

            // Recharge Button
            ElevatedButton(
              onPressed: () {
                if (_mobileNumber.isEmpty ||
                    _selectedOperator == 'Select Operator' ||
                    _selectedPlan.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please complete all fields')),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RechargeScreen(
                        mobileNumber: _mobileNumber,
                        operator: _selectedOperator,
                        plan: _selectedPlan,
                      ),
                    ),
                  );
                }
              },
              child: Text('Recharge Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
