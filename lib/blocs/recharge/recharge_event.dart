import 'package:equatable/equatable.dart';


// Events
abstract class RechargeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRechargeOptions extends RechargeEvent {}
