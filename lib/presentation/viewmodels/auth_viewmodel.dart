import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_viewmodel.freezed.dart';

/// États du ViewModel Auth
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success() = AuthSuccess;
  const factory AuthState.error(String message) = AuthError;
}

/// ViewModel pour l'authentification
class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthViewModel(this._repository) : super(const AuthState.initial());

  Future<void> signIn(String email, String password) async {
    state = const AuthState.loading();

    try {
      await _repository.signIn(email: email, password: password);
      state = const AuthState.success();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = const AuthState.loading();

    try {
      await _repository.signUp(
        email: email,
        password: password,
        displayName: name,
      );
      state = const AuthState.success();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AuthState.loading();

    try {
      await _repository.resetPassword(email);
      state = const AuthState.success();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Connexion avec Google Sign-In
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    try {
      // Cast le repository en AuthRepositoryImpl pour accéder à la méthode signInWithGoogle
      if (_repository is AuthRepositoryImpl) {
        await (_repository as AuthRepositoryImpl).signInWithGoogle();
        state = const AuthState.success();
      } else {
        throw Exception('Google Sign-In non disponible');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  void reset() {
    state = const AuthState.initial();
  }
}
