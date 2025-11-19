import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers.dart';
import '../../widgets/product_image.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Utilisateur non connecté')),
      );
    }

    final ordersUseCase = ref.watch(getUserOrdersUseCaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes commandes')),
      body: FutureBuilder<List<Order>>(
        future: ordersUseCase(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(child: Text('Aucune commande'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text('Commande #${order.id.substring(0, 8)}'),
                  subtitle: Text(
                    '${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year} - ${order.total.toStringAsFixed(2)} €',
                  ),
                  children: [
                    ...order.items.map(
                      (item) => ListTile(
                        leading: ProductImage(
                          imageUrl: item.product.thumbnail,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.product.title),
                        subtitle: Text('Quantité: ${item.quantity}'),
                        trailing: Text('${item.subtotal.toStringAsFixed(2)} €'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
