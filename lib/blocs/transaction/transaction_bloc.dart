
// BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_recharge/blocs/transaction/transaction_event.dart';
import 'package:mobile_recharge/blocs/transaction/transaction_state.dart';
import 'package:mobile_recharge/repositories/transaction_repository.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc({required this.transactionRepository}) : super(TransactionInitial()) {
    on<FetchTransactions>(_onFetchTransactions);
    on<AddTransaction>(_onAddTransaction);
  }

  Future<void> _onFetchTransactions(FetchTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      final transactions = await transactionRepository.getTransactions();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(AddTransaction event, Emitter<TransactionState> emit) async {
    final currentState = state;
    if (currentState is TransactionLoaded) {
      try {
        await transactionRepository.addTransaction(event.transaction);
        final updatedTransactions = await transactionRepository.getTransactions();
        emit(TransactionLoaded(updatedTransactions));
      } catch (e) {
        emit(TransactionError(e.toString()));
      }
    }
  }
}