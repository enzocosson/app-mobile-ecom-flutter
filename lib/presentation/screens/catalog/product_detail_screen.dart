import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/providers.dart';
import '../../widgets/product_image.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productByIdProvider(productId));

    return productAsync.when(
      data: (product) {
        if (product == null) {
          return _buildNotFound(context);
        }

        // Adaptation iOS : Utiliser CupertinoPageScaffold
        if (!kIsWeb && Platform.isIOS) {
          return _buildIOSScreen(context, ref, product);
        }

        return _buildAndroidScreen(context, ref, product);
      },
      loading: () => _buildLoading(),
      error: (err, stack) => _buildError(context, err),
    );
  }

  /// Écran iOS avec design Cupertino
  Widget _buildIOSScreen(BuildContext context, WidgetRef ref, product) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.share),
          onPressed: () => _shareProduct(product),
        ),
        previousPageTitle: 'Retour',
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Image principale
            SliverToBoxAdapter(
              child: ProductImage(
                imageUrl: product.thumbnail,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Contenu
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Prix et titre
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${product.price.toStringAsFixed(2)} €',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: CupertinoColors.systemBlue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Informations détaillées
                    CupertinoListSection.insetGrouped(
                      backgroundColor: CupertinoColors.systemBackground,
                      children: [
                        if (product.category != null)
                          CupertinoListTile(
                            leading: const Icon(CupertinoIcons.tag),
                            title: const Text('Catégorie'),
                            trailing: Text(
                              product.category,
                              style: const TextStyle(
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                        if (product.rating != null)
                          CupertinoListTile(
                            leading: const Icon(CupertinoIcons.star_fill),
                            title: const Text('Note'),
                            trailing: Text(
                              '${product.rating?.toStringAsFixed(1)} / 5',
                              style: const TextStyle(
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                        if (product.stock != null)
                          CupertinoListTile(
                            leading: Icon(
                              product.stock! > 0
                                  ? CupertinoIcons.checkmark_circle_fill
                                  : CupertinoIcons.xmark_circle_fill,
                              color: product.stock! > 0
                                  ? CupertinoColors.systemGreen
                                  : CupertinoColors.systemRed,
                            ),
                            title: const Text('Disponibilité'),
                            trailing: Text(
                              product.stock! > 0
                                  ? '${product.stock} en stock'
                                  : 'Rupture de stock',
                              style: TextStyle(
                                color: product.stock! > 0
                                    ? CupertinoColors.systemGreen
                                    : CupertinoColors.systemRed,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Galerie d'images
                    if (product.images.length > 1) ...[
                      const Text(
                        'Plus d\'images',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ProductImage(
                                  imageUrl: product.images[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],

                    // Bouton Ajouter au panier
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: () {
                          ref
                              .read(cartViewModelProvider.notifier)
                              .addToCart(product);
                          _showIOSSnackbar(context, 'Produit ajouté au panier');
                        },
                        child: const Text(
                          'Ajouter au panier',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Écran Android avec design Material
  Widget _buildAndroidScreen(BuildContext context, WidgetRef ref, product) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareProduct(product),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ProductImage(
                imageUrl: product.thumbnail,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Prix
            Text(
              '${product.price.toStringAsFixed(2)} €',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),

            // Titre
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Description
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            // Bouton Ajouter au panier
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(cartViewModelProvider.notifier).addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Produit ajouté au panier')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Ajouter au panier',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Écran de chargement
  Widget _buildLoading() {
    if (!kIsWeb && Platform.isIOS) {
      return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Chargement...'),
        ),
        child: Center(
          child: CupertinoActivityIndicator(radius: 20),
        ),
      );
    }
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  /// Écran d'erreur
  Widget _buildError(BuildContext context, Object err) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Erreur'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.exclamationmark_triangle,
                size: 64,
                color: CupertinoColors.systemRed,
              ),
              const SizedBox(height: 16),
              Text(
                'Erreur: $err',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Erreur')),
      body: Center(child: Text('Erreur: $err')),
    );
  }

  /// Écran produit introuvable
  Widget _buildNotFound(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) {
      return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Produit introuvable'),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.search,
                size: 64,
                color: CupertinoColors.systemGrey,
              ),
              SizedBox(height: 16),
              Text(
                'Ce produit n\'existe pas',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Produit introuvable')),
      body: const Center(child: Text('Ce produit n\'existe pas')),
    );
  }

  /// Partager le produit
  Future<void> _shareProduct(product) async {
    try {
      await Share.share(
        '${product.title}\n\n'
        '${product.description}\n\n'
        'Prix: ${product.price.toStringAsFixed(2)} €\n\n'
        'Disponible sur ShopFlutter',
        subject: product.title,
      );
    } catch (e) {
      debugPrint('Erreur lors du partage: $e');
    }
  }

  /// Afficher un message iOS style
  void _showIOSSnackbar(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: CupertinoColors.systemGreen,
            ),
            const SizedBox(width: 12),
            Flexible(child: Text(message)),
          ],
        ),
      ),
    );

    // Auto-dismiss après 1.5 secondes
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }
}
