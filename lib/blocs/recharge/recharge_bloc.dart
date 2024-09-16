// BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_recharge/blocs/recharge/recharge_event.dart';
import 'package:mobile_recharge/blocs/recharge/recharge_state.dart';
import 'package:mobile_recharge/repositories/recharge_repository.dart';

class RechargeBloc extends Bloc<RechargeEvent, RechargeState> {
  final RechargeRepository rechargeRepository;

  RechargeBloc(this.rechargeRepository) : super(RechargeInitial()) {
    on<FetchRechargeOptions>(_onFetchRechargeOptions);
  }

  Future<void> _onFetchRechargeOptions(
    FetchRechargeOptions event,
    Emitter<RechargeState> emit,
  ) async {
    emit(RechargeLoading());
    try {
      final rechargeOptions = await rechargeRepository.getRechargeOptions();
      emit(RechargeLoaded(rechargeOptions));
    } catch (e) {
      emit(RechargeError('Failed to fetch recharge options'));
    }
  }
}