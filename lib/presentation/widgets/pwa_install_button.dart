import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;

/// Widget qui affiche un bouton pour installer la PWA (Web uniquement)
class PWAInstallButton extends StatefulWidget {
  const PWAInstallButton({super.key});

  @override
  State<PWAInstallButton> createState() => _PWAInstallButtonState();
}

class _PWAInstallButtonState extends State<PWAInstallButton> {
  bool _canInstall = false;
  dynamic _deferredPrompt;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _setupInstallPrompt();
    }
  }

  void _setupInstallPrompt() {
    // Écouter l'événement beforeinstallprompt
    html.window.addEventListener('beforeinstallprompt', (event) {
      // Empêcher l'affichage automatique du prompt
      event.preventDefault();

      setState(() {
        _deferredPrompt = event;
        _canInstall = true;
      });
    });

    // Écouter l'événement appinstalled
    html.window.addEventListener('appinstalled', (event) {
      setState(() {
        _canInstall = false;
        _deferredPrompt = null;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Application installée avec succès !'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  Future<void> _installPWA() async {
    if (_deferredPrompt == null) return;

    try {
      // Afficher le prompt d'installation
      final prompt = _deferredPrompt;
      prompt.prompt();

      // Attendre le choix de l'utilisateur (simplifié)
      await Future.delayed(const Duration(milliseconds: 500));

      debugPrint('✅ Prompt d\'installation PWA affiché');

      setState(() {
        _deferredPrompt = null;
        _canInstall = false;
      });
    } catch (e) {
      debugPrint('Erreur lors de l\'installation PWA: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'installation: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // N'afficher que sur le Web et si l'installation est possible
    if (!kIsWeb || !_canInstall) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: _installPWA,
        icon: const Icon(Icons.download, color: Colors.white),
        label: const Text(
          'Installer l\'application',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
