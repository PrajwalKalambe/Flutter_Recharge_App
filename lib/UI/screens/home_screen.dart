import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_recharge/blocs/auth/auth_event.dart';
import 'package:mobile_recharge/blocs/auth/auth_state.dart';
import 'package:mobile_recharge/blocs/recharge/recharge_event.dart';
import 'package:mobile_recharge/blocs/recharge/recharge_state.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/recharge/recharge_bloc.dart';
import '../widgets/recharge_option_card.dart';
import 'recharge_screen.dart';
import 'transaction_history_screen.dart';
import 'auth_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Recharge App'),
              actions: [
                IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
                  },
                ),
              ],
            ),
            body: BlocBuilder<RechargeBloc, RechargeState>(
              builder: (context, state) {
                if (state is RechargeInitial) {
                  BlocProvider.of<RechargeBloc>(context).add(FetchRechargeOptions());
                  return Center(child: CircularProgressIndicator());
                } else if (state is RechargeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is RechargeLoaded) {
                  return GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: state.rechargeOptions.length,
                    itemBuilder: (context, index) {
                      final option = state.rechargeOptions[index];
                      return RechargeOptionCard(
                        rechargeOption: option,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RechargeScreen(rechargeOption: option),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is RechargeError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return Center(child: Text('Unknown state'));
              },
            ),
          );
        } else {
          return AuthScreen();
        }
      },
    );
  }
}