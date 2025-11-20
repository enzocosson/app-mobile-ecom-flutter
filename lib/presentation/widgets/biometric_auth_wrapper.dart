import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/biometric_providers.dart';

/// Wrapper qui demande l'authentification biométrique sur iOS au démarrage
class BiometricAuthWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const BiometricAuthWrapper({super.key, required this.child});

  @override
  ConsumerState<BiometricAuthWrapper> createState() =>
      _BiometricAuthWrapperState();
}

class _BiometricAuthWrapperState extends ConsumerState<BiometricAuthWrapper>
    with WidgetsBindingObserver {
  bool _isAuthenticated = false;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAndAuthenticate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Demander l'authentification quand l'app revient au premier plan (spécifique iOS)
    if (state == AppLifecycleState.resumed && !_isAuthenticated) {
      _checkAndAuthenticate();
    }
  }

  Future<void> _checkAndAuthenticate() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      final shouldUseBiometric = await ref.read(
        shouldUseBiometricOnIOSProvider.future,
      );

      if (shouldUseBiometric) {
        final service = ref.read(biometricAuthServiceProvider);
        final authenticated = await service.authenticate(
          reason: 'Authentifiez-vous pour accéder à ShopFlutter',
        );

        setState(() {
          _isAuthenticated = authenticated;
          _isAuthenticating = false;
        });
      } else {
        // Pas de biométrie disponible, autoriser l'accès
        setState(() {
          _isAuthenticated = true;
          _isAuthenticating = false;
        });
      }
    } catch (e) {
      debugPrint('Erreur d\'authentification biométrique: $e');
      setState(() {
        _isAuthenticated = true; // Autoriser l'accès en cas d'erreur
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticating || !_isAuthenticated) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fingerprint, size: 100, color: Colors.blue),
                const SizedBox(height: 24),
                const Text(
                  'Authentification requise',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (_isAuthenticating)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _checkAndAuthenticate,
                    child: const Text('Se connecter'),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return widget.child;
  }
}
