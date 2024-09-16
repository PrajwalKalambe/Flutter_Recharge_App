// States
import 'package:equatable/equatable.dart';
import 'package:mobile_recharge/models/recharge_option.dart';

abstract class RechargeState extends Equatable {
  @override
  List<Object> get props => [];
}

class RechargeInitial extends RechargeState {}

class RechargeLoading extends RechargeState {}

class RechargeLoaded extends RechargeState {
  final List<RechargeOption> rechargeOptions;

  RechargeLoaded(this.rechargeOptions);

  @override
  List<Object> get props => [rechargeOptions];
}

class RechargeError extends RechargeState {
  final String message;

  RechargeError(this.message);

  @override
  List<Object> get props => [message];
}
