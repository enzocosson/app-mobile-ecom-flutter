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
          // Bouton de partage natif Android
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareProduct(product),
            tooltip: 'Partager',
          ),
          // Menu avec options supplémentaires
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'share_details':
                  _shareProductDetails(product);
                  break;
                case 'share_link':
                  _shareProductLink(product);
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share_details',
                child: Row(
                  children: [
                    Icon(Icons.description, size: 20),
                    SizedBox(width: 8),
                    Text('Partager les détails'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'share_link',
                child: Row(
                  children: [
                    Icon(Icons.link, size: 20),
                    SizedBox(width: 8),
                    Text('Partager le lien'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image avec Hero animation
            Hero(
              tag: 'product_${product.id}',
              child: ProductImage(
                imageUrl: product.thumbnail,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Prix et disponibilité
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${product.price.toStringAsFixed(2)} €',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                      if (product.stock != null)
                        Chip(
                          avatar: Icon(
                            product.stock! > 0
                                ? Icons.check_circle
                                : Icons.cancel,
                            size: 16,
                            color:
                                product.stock! > 0 ? Colors.green : Colors.red,
                          ),
                          label: Text(
                            product.stock! > 0
                                ? '${product.stock} en stock'
                                : 'Rupture',
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: product.stock! > 0
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Titre
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Catégorie et note
                  Wrap(
                    spacing: 8,
                    children: [
                      if (product.category != null)
                        Chip(
                          avatar: const Icon(Icons.category, size: 16),
                          label: Text(product.category),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      if (product.rating != null)
                        Chip(
                          avatar: const Icon(Icons.star, size: 16),
                          label:
                              Text('${product.rating?.toStringAsFixed(1)} / 5'),
                          backgroundColor: Colors.amber.shade50,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const SizedBox(height: 24),

                  // Galerie d'images
                  if (product.images.length > 1) ...[
                    Text(
                      'Plus d\'images',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                    const SizedBox(height: 24),
                  ],

                  // Boutons d'action
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(cartViewModelProvider.notifier)
                                .addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.white),
                                    SizedBox(width: 8),
                                    Text('Produit ajouté au panier'),
                                  ],
                                ),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                  label: 'VOIR',
                                  textColor: Colors.white,
                                  onPressed: () {
                                    // Navigation vers le panier
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text(
                            'Ajouter au panier',
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _shareProduct(product),
                          icon: const Icon(Icons.share),
                          label: const Text('Partager'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showShareOptions(context, product),
        icon: const Icon(Icons.share),
        label: const Text('Partager'),
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

  /// Partager les détails complets du produit
  Future<void> _shareProductDetails(product) async {
    try {
      final buffer = StringBuffer();
      buffer.writeln('🛍️ ${product.title}');
      buffer.writeln('');
      buffer.writeln('💰 Prix: ${product.price.toStringAsFixed(2)} €');
      if (product.category != null) {
        buffer.writeln('📂 Catégorie: ${product.category}');
      }
      if (product.rating != null) {
        buffer.writeln('⭐ Note: ${product.rating?.toStringAsFixed(1)} / 5');
      }
      if (product.stock != null) {
        buffer.writeln(
            '📦 Stock: ${product.stock! > 0 ? "${product.stock} disponibles" : "Rupture de stock"}');
      }
      buffer.writeln('');
      buffer.writeln('📝 Description:');
      buffer.writeln(product.description);
      buffer.writeln('');
      buffer.writeln('✨ Disponible sur ShopFlutter');

      await Share.share(
        buffer.toString(),
        subject: '${product.title} - ShopFlutter',
      );
    } catch (e) {
      debugPrint('Erreur lors du partage des détails: $e');
    }
  }

  /// Partager uniquement le lien
  Future<void> _shareProductLink(product) async {
    try {
      await Share.share(
        '🔗 Découvrez ${product.title} sur ShopFlutter!\n'
        'Prix: ${product.price.toStringAsFixed(2)} €\n\n'
        '[Lien vers le produit - À configurer]',
        subject: product.title,
      );
    } catch (e) {
      debugPrint('Erreur lors du partage du lien: $e');
    }
  }

  /// Afficher les options de partage dans un bottom sheet
  void _showShareOptions(BuildContext context, product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Partager ce produit',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.share, color: Colors.white),
                ),
                title: const Text('Partage rapide'),
                subtitle: const Text('Partager avec vos applications'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProduct(product);
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.description, color: Colors.white),
                ),
                title: const Text('Détails complets'),
                subtitle: const Text('Partager toutes les informations'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProductDetails(product);
                },
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.link, color: Colors.white),
                ),
                title: const Text('Lien uniquement'),
                subtitle: const Text('Partager un lien vers le produit'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProductLink(product);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
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
