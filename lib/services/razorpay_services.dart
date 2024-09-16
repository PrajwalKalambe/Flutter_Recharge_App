import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

class RazorpayService {
  late Razorpay _razorpay;
  final Function(PaymentSuccessResponse) onPaymentSuccess;
  final Function(PaymentFailureResponse) onPaymentError;
  final Function(ExternalWalletResponse) onExternalWallet;

  RazorpayService({
    required this.onPaymentSuccess,
    required this.onPaymentError,
    required this.onExternalWallet,
  }) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onPaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void openCheckout({
    required String key,
    required double amount,
    required String name,
    required String description,
    required String orderId,
    String prefillContact = '',
    String prefillEmail = '',
  }) async {
    var options = {
      'key': key,
      'amount': (amount * 100).toInt(), // Convert to paise
      'name': name,
      'description': description,
      'order_id': orderId,
      'prefill': {'contact': prefillContact, 'email': prefillEmail},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  static Future<String> createOrder({
    required String key,
    required String secret,
    required int amount,
    required String currency,
  }) async {
    // Note: In a real-world scenario, you should create the order on your server
    // and return the order ID to the app. This is just a placeholder.
    // You should not expose your Razorpay secret key in the app.
    throw UnimplementedError('Server-side order creation not implemented');
  }
}