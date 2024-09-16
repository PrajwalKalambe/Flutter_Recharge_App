import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentScreen extends StatefulWidget {
  final String mobileNumber;
  final String operator;
  final String plan;
  final int amount; // in INR

  PaymentScreen({
    required this.mobileNumber,
    required this.operator,
    required this.plan,
    required this.amount,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  bool _isLoading = false;

  final String razorpayKey = "YOUR_RAZORPAY_KEY_ID"; // Replace with your Razorpay Key ID

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() {
    var options = {
      'key': razorpayKey,
      'amount': widget.amount * 100, // Razorpay takes amount in paise
      'name': 'Mobile Recharge',
      'description': 'Recharge Amount',
      'prefill': {
        'contact': '9876543210', // You can fetch user contact from profile
        'email': 'user@example.com' // You can fetch user email from profile
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error in payment: ${e.toString()}')),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Payment successful, process the recharge
    setState(() {
      _isLoading = true;
    });

    // Example: Save recharge details to Firestore
    await FirebaseFirestore.instance.collection('recharges').add({
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'mobileNumber': widget.mobileNumber,
      'operator': widget.operator,
      'plan': widget.plan,
      'amount': widget.amount,
      'paymentId': response.paymentId,
      'status': 'Success',
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      _isLoading = false;
    });

    // Notify user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful! Recharge initiated.')),
    );

    // Optionally, navigate back or to another screen
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    // Payment failed, notify user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );

    // Optionally, save failed payment details
    await FirebaseFirestore.instance.collection('recharges').add({
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'mobileNumber': widget.mobileNumber,
      'operator': widget.operator,
      'plan': widget.plan,
      'amount': widget.amount,
      // 'paymentId': response.paymentId,
      'paymentId': '1',
      'error': response.message,
      'status': 'Failed',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet Selected: ${response.walletName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.payment),
                      title: Text('Amount'),
                      subtitle: Text('₹${widget.amount}'),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: openCheckout,
                      child: Text('Pay Now'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ));
  }
}
