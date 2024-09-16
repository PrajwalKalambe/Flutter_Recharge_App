import '../models/recharge_option.dart';

class RechargeRepository {
  final List<RechargeOption> _rechargeOptions = [
    RechargeOption(
      id: '1',
      name: 'Mobile Recharge',
      icon: 'assets/icons/mobile.png',
      description: 'Recharge your mobile phone',
    ),
    RechargeOption(
      id: '2',
      name: 'Electricity Bill',
      icon: 'assets/icons/electricity.png',
      description: 'Pay your electricity bill',
    ),
    RechargeOption(
      id: '3',
      name: 'Water Bill',
      icon: 'assets/icons/water.png',
      description: 'Pay your water bill',
    ),
    RechargeOption(
      id: '4',
      name: 'FASTag Recharge',
      icon: 'assets/icons/fastag.png',
      description: 'Recharge your FASTag',
    ),
  ];

  Future<List<RechargeOption>> getRechargeOptions() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    return _rechargeOptions;
  }

  Future<RechargeOption> getRechargeOptionById(String id) async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));
    return _rechargeOptions.firstWhere((option) => option.id == id);
  }
}