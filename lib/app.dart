import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_recharge/main.dart';
import 'package:mobile_recharge/repositories/auth_repository.dart';
import 'package:mobile_recharge/repositories/recharge_repository.dart';
import 'package:mobile_recharge/repositories/transaction_repository.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/recharge/recharge_bloc.dart';
import 'blocs/transaction/transaction_bloc.dart';
import 'ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(getIt<AuthRepository>()),
        ),
        BlocProvider<RechargeBloc>(
          create: (context) => RechargeBloc(getIt<RechargeRepository>()),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(getIt<TransactionRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Recharge App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}