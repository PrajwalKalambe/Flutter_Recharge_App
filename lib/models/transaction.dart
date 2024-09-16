import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String id;
  final String userId;
  final String rechargeOptionId;
  final double amount;
  final DateTime timestamp;
  final String status;

  const Transaction({
    required this.id,
    required this.userId,
    required this.rechargeOptionId,
    required this.amount,
    required this.timestamp,
    required this.status,
  });

  @override
  List<Object> get props => [id, userId, rechargeOptionId, amount, timestamp, status];

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['userId'],
      rechargeOptionId: json['rechargeOptionId'],
      amount: json['amount'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'rechargeOptionId': rechargeOptionId,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }
}