import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers.dart';
import '../../widgets/product_image.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(catalogViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: catalogState is CatalogStateLoaded
          ? ListView.builder(
              itemCount: catalogState.products.length,
              itemBuilder: (context, index) {
                final product = catalogState.products[index];
                return ListTile(
                  leading: ProductImage(
                    imageUrl: product.thumbnail,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text('${product.price.toStringAsFixed(2)} €'),
                  onTap: () => context.push('/product/${product.id}'),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
