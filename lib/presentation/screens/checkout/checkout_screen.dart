import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _isProcessing = false;

  Future<void> _processCheckout() async {
    setState(() => _isProcessing = true);

    try {
      // Simul paiement
      await Future.delayed(const Duration(seconds: 2));

      // Récupérer les items du panier
      final cartState = ref.read(cartViewModelProvider);
      if (cartState is! CartStateLoaded) return;

      // Créer la commande
      final user = ref.read(currentUserProvider);
      if (user == null) return;

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.id,
        items: cartState.items,
        total: cartState.total,
        createdAt: DateTime.now(),
        status: OrderStatus.completed,
      );

      final createOrderUseCase = ref.read(createOrderUseCaseProvider);
      await createOrderUseCase(order);

      // Vider le panier
      await ref.read(cartRepositoryProvider).clearCart();

      if (!mounted) return;

      // Afficher confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Commande passée avec succès !')),
      );

      context.go('/orders');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paiement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.credit_card, size: 100, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Paiement mocké',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Cette application utilise un système de paiement simulé.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processCheckout,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Confirmer le paiement',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
