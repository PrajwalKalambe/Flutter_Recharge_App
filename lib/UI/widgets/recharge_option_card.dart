import 'package:flutter/material.dart';
import '../../models/recharge_option.dart';

class RechargeOptionCard extends StatelessWidget {
  final RechargeOption rechargeOption;
  final VoidCallback onTap;

  const RechargeOptionCard({
    Key? key,
    required this.rechargeOption,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                rechargeOption.icon,
                height: 48,
                width: 48,
              ),
              SizedBox(height: 8),
              Text(
                rechargeOption.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Text(
                rechargeOption.description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}