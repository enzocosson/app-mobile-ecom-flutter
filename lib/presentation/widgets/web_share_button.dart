import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../../domain/entities/product.dart';

/// Bouton de partage Web Share API pour partager la liste des produits
class WebShareButton extends StatelessWidget {
  final List<Product> products;

  const WebShareButton({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // N'afficher que sur le web
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(Icons.share),
      tooltip: 'Partager la liste',
      onPressed: () => _shareProducts(context),
    );
  }

  Future<void> _shareProducts(BuildContext context) async {
    if (!kIsWeb) return;

    try {
      // Toujours utiliser le fallback avec options email et copie
      _showFallbackShare(context);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  String _buildShareText() {
    final buffer = StringBuffer();
    buffer.writeln('🛍️ Découvrez notre catalogue de produits !\n');

    for (var i = 0; i < products.length && i < 10; i++) {
      final product = products[i];
      buffer
          .writeln('• ${product.title} - ${product.price.toStringAsFixed(2)}€');
    }

    if (products.length > 10) {
      buffer.writeln('\n... et ${products.length - 10} autres produits !');
    }

    buffer.writeln('\n✨ Visitez notre boutique en ligne !');
    buffer.writeln(html.window.location.href);

    return buffer.toString();
  }

  void _showFallbackShare(BuildContext context) {
    final shareText = _buildShareText();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.share, color: Colors.blue),
            SizedBox(width: 8),
            Text('Partager la liste'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Choisissez comment partager la liste de produits :',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                constraints: const BoxConstraints(maxHeight: 200),
                child: SingleChildScrollView(
                  child: SelectableText(
                    shareText,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _shareViaEmail(shareText),
                icon: const Icon(Icons.email),
                label: const Text('Partager par Email'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _copyToClipboard(context, shareText),
                icon: const Icon(Icons.content_copy),
                label: const Text('Copier dans le presse-papiers'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _shareViaEmail(String text) {
    final subject = Uri.encodeComponent('Liste des produits - ShopFlutter');
    final body = Uri.encodeComponent(text);
    final mailtoLink = 'mailto:?subject=$subject&body=$body';

    html.window.open(mailtoLink, '_self');
  }

  void _copyToClipboard(BuildContext context, String text) {
    // Utiliser l'API Clipboard moderne
    try {
      html.window.navigator.clipboard?.writeText(text);

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Texte copié dans le presse-papiers !'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Impossible de copier. Sélectionnez le texte manuellement.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
