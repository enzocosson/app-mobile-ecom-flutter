import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers.dart';
import '../../widgets/product_card.dart';
import '../../widgets/pwa_install_button.dart';

/// Écran d'accueil avec liste de produits
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopFlutter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => context.push('/cart'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 1) {
            context.push('/orders');
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Commandes',
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    final catalogState = ref.watch(catalogViewModelProvider);

    return Column(
      children: [
        // Bouton PWA (visible uniquement sur Web)
        const PWAInstallButton(),

        Expanded(
          child: switch (catalogState) {
            CatalogStateLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CatalogStateError(:final message) => Center(
              child: Text('Erreur: $message'),
            ),
            CatalogStateLoaded(:final products) => RefreshIndicator(
              onRefresh: () async {
                ref.read(catalogViewModelProvider.notifier).loadProducts();
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
            _ => const Center(child: Text('État inconnu')),
          },
        ),
      ],
    );
  }
}
