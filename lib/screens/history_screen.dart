import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Recharge History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recharges')
            .where('userId', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching history'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data?.docs;

          if (data == null || data.isEmpty) {
            return Center(child: Text('No recharge history found'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var recharge = data[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: Icon(
                  recharge['status'] == 'Success' ? Icons.check_circle : Icons.error,
                  color: recharge['status'] == 'Success' ? Colors.green : Colors.red,
                ),
                title: Text('${recharge['operator']} - ${recharge['plan']}'),
                subtitle: Text('₹${recharge['amount']}'),
                trailing: Text(
                  recharge['status'],
                  style: TextStyle(
                    color: recharge['status'] == 'Success' ? Colors.green : Colors.red,
                  ),
                ),
                // Optionally, show date/time
                // subtitle: Text(DateFormat.yMMMd().add_jm().format(recharge['timestamp'].toDate())),
              );
            },
          );
        },
      ),
    );
  }
}
