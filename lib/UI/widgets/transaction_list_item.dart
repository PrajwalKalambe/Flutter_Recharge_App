import 'package:flutter/material.dart';
import '../../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(_getIconForRechargeOption(transaction.rechargeOptionId)),
      ),
      title: Text('₹${transaction.amount.toStringAsFixed(2)}'),
      subtitle: Text(date('dd MMM yyyy, HH:mm').format(transaction.timestamp)),
      trailing: _getStatusChip(transaction.status),
    );
  }

  IconData _getIconForRechargeOption(String rechargeOptionId) {
    // TODO: Implement logic to return appropriate icon based on rechargeOptionId
    return Icons.phone_android;
  }

  Widget _getStatusChip(String status) {
    Color color;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'success':
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case 'pending':
        color = Colors.orange;
        icon = Icons.access_time;
        break;
      case 'failed':
        color = Colors.red;
        icon = Icons.error;
        break;
      default:
        color = Colors.grey;
        icon = Icons.help;
    }

    return Chip(
      label: Text(
        status,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      avatar: Icon(icon, color: Colors.white, size: 16),
    );
  }
}