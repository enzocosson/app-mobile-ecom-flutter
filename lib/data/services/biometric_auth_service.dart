import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:io' show Platform;

/// Service d'authentification biométrique pour iOS/Android
class BiometricAuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Vérifie si la biométrie est disponible sur l'appareil
  Future<bool> isBiometricAvailable() async {
    if (kIsWeb) return false;

    try {
      final bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();

      return canCheckBiometrics && isDeviceSupported;
    } catch (e) {
      debugPrint('Erreur lors de la vérification de la biométrie: $e');
      return false;
    }
  }

  /// Récupère les types de biométrie disponibles
  Future<List<BiometricType>> getAvailableBiometrics() async {
    if (kIsWeb) return [];

    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des biométries: $e');
      return [];
    }
  }

  /// Authentifie l'utilisateur avec la biométrie
  Future<bool> authenticate({
    String reason = 'Veuillez vous authentifier pour accéder à l\'application',
  }) async {
    if (kIsWeb) return false;

    try {
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false, // Permet le code PIN comme fallback
        ),
      );

      return didAuthenticate;
    } on PlatformException catch (e) {
      debugPrint('Erreur d\'authentification: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Erreur inattendue: $e');
      return false;
    }
  }

  /// Vérifie si l'appareil est iOS et la biométrie est disponible
  Future<bool> shouldUseBiometricOnIOS() async {
    if (kIsWeb) return false;
    if (!Platform.isIOS) return false;

    final available = await isBiometricAvailable();
    final biometrics = await getAvailableBiometrics();

    // Vérifier si Face ID ou Touch ID est disponible
    return available &&
        (biometrics.contains(BiometricType.face) ||
            biometrics.contains(BiometricType.fingerprint));
  }
}
