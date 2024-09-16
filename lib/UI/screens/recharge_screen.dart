import 'package:flutter/material.dart';
import '../../models/recharge_option.dart';
// import '../../services/razorpay_service.dart';

class RechargeScreen extends StatefulWidget {
  final RechargeOption rechargeOption;

  RechargeScreen({required this.rechargeOption});

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _identifierController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rechargeOption.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _identifierController,
                decoration: InputDecoration(
                  labelText: 'Enter ${widget.rechargeOption.name} Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Enter Amount',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _initiatePayment();
                  }
                },
                child: Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initiatePayment() {
    final amount = double.parse(_amountController.text);
    final identifier = _identifierController.text;

    // TODO: Implement Razorpay payment logic
    // For now, we'll just show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment Initiated'),
        content: Text('Payment of ₹$amount for ${widget.rechargeOption.name} ($identifier) initiated.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}