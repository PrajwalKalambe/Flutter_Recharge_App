import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_recharge/services/firebase_services.dart';
import 'package:mobile_recharge/services/razorpay_services.dart';
import 'app.dart';
import 'repositories/auth_repository.dart';
import 'repositories/recharge_repository.dart';
import 'repositories/transaction_repository.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Register services and repositories
  getIt.registerSingleton<FirebaseService>(FirebaseService());
  getIt.registerSingleton<RazorpayService>(RazorpayService());
  getIt.registerSingleton<AuthRepository>(AuthRepository(getIt<FirebaseService>()));
  getIt.registerSingleton<RechargeRepository>(RechargeRepository());
  getIt.registerSingleton<TransactionRepository>(TransactionRepository(getIt<FirebaseService>()));

  runApp(MyApp());
}