import 'package:equatable/equatable.dart';
import '../../models/transaction.dart';

// Events
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final Transaction transaction;

  const AddTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}