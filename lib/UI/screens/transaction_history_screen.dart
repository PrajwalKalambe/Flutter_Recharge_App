import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_recharge/blocs/transaction/transaction_event.dart';
import 'package:mobile_recharge/blocs/transaction/transaction_state.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../widgets/transaction_list_item.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionInitial) {
            BlocProvider.of<TransactionBloc>(context).add(FetchTransactions());
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final transaction = state.transactions[index];
                return TransactionListItem(transaction: transaction);
              },
            );
          } else if (state is TransactionError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}