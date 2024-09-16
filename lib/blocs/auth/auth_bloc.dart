
// BLoC
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_recharge/blocs/auth/auth_event.dart';
import 'package:mobile_recharge/blocs/auth/auth_state.dart';
import 'package:mobile_recharge/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final isSignedIn = await authRepository.isSignedIn();
      if (isSignedIn) {
        final userId = await authRepository.getCurrentUser();
        emit(Authenticated(userId));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userId = await authRepository.signIn(event.email, event.password);
      emit(Authenticated(userId));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final userId = await authRepository.signUp(event.email, event.password);
      emit(Authenticated(userId));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}