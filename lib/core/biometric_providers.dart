import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/services/biometric_auth_service.dart';

/// Provider pour le service d'authentification biométrique
final biometricAuthServiceProvider = Provider<BiometricAuthService>((ref) {
  return BiometricAuthService();
});

/// Provider pour vérifier si la biométrie est disponible
final biometricAvailableProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(biometricAuthServiceProvider);
  return await service.isBiometricAvailable();
});

/// Provider pour iOS spécifiquement
final shouldUseBiometricOnIOSProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(biometricAuthServiceProvider);
  return await service.shouldUseBiometricOnIOS();
});
