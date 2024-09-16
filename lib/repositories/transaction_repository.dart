import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionRepository {
  final FirebaseFirestore _firestore;

  TransactionRepository({FirebaseFirestore? firestore}) 
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Transaction>> getTransactions() async {
    try {
      final snapshot = await _firestore.collection('transactions').get();
      return snapshot.docs.map((doc) => Transaction.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _firestore.collection('transactions').add(transaction.toJson());
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  Stream<List<Transaction>> getTransactionStream(String userId) {
    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Transaction.fromJson(doc.data())).toList();
    });
  }

  Future<void> updateTransactionStatus(String transactionId, String status) async {
    try {
      await _firestore.collection('transactions').doc(transactionId).update({
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to update transaction status: $e');
    }
  }
}