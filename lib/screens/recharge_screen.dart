import 'package:flutter/material.dart';
import 'payment_screen.dart';

class RechargeScreen extends StatelessWidget {
  final String mobileNumber;
  final String operator;
  final String plan;

  RechargeScreen({
    required this.mobileNumber,
    required this.operator,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    // You can parse the plan price from the string
    final int planPrice = int.parse(plan);

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Recharge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Mobile Number'),
              subtitle: Text(mobileNumber),
            ),
            ListTile(
              leading: Icon(Icons.network_check),
              title: Text('Operator'),
              subtitle: Text(operator),
            ),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text('Plan'),
              subtitle: Text(plan),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                            mobileNumber: mobileNumber,
                            operator: operator,
                            plan: plan,
                            amount: planPrice,
                          )),
                );
              },
              child: Text('Proceed to Pay'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
