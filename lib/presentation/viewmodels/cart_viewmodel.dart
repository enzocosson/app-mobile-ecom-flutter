import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';
import '../../core/providers.dart';

part 'cart_viewmodel.freezed.dart';

/// ViewModel pour le panier
class CartViewModel extends StateNotifier<CartState> {
  final Ref _ref;

  CartViewModel(this._ref) : super(const CartState.loading()) {
    loadCart();
  }

  Future<void> loadCart() async {
    print('🛒 Chargement du panier...');
    state = const CartState.loading();

    try {
      final useCase = _ref.read(getCartItemsUseCaseProvider);
      final items = await useCase();
      print('✅ Articles récupérés: ${items.length}');

      final totalUseCase = _ref.read(calculateCartTotalUseCaseProvider);
      final total = await totalUseCase();
      print('✅ Total calculé: $total €');

      state = CartState.loaded(items, total);
      print('✅ État du panier mis à jour');
    } catch (e, stackTrace) {
      print('❌ Erreur lors du chargement du panier: $e');
      print('Stack trace: $stackTrace');
      state = CartState.error(e.toString());
    }
  }

  Future<void> addToCart(Product product, {int quantity = 1}) async {
    try {
      final useCase = _ref.read(addToCartUseCaseProvider);
      await useCase(product, quantity: quantity);
      await loadCart();
    } catch (e) {
      state = CartState.error(e.toString());
    }
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final repo = _ref.read(cartRepositoryProvider);
      await repo.updateQuantity(productId, quantity);
      await loadCart();
    } catch (e) {
      state = CartState.error(e.toString());
    }
  }

  Future<void> removeItem(int productId) async {
    try {
      final repo = _ref.read(cartRepositoryProvider);
      await repo.removeFromCart(productId);
      await loadCart();
    } catch (e) {
      state = CartState.error(e.toString());
    }
  }

  Future<void> clearCart() async {
    try {
      final repo = _ref.read(cartRepositoryProvider);
      await repo.clearCart();
      await loadCart();
    } catch (e) {
      state = CartState.error(e.toString());
    }
  }
}

/// États possibles pour le panier
@freezed
class CartState with _$CartState {
  const factory CartState.loading() = CartStateLoading;
  const factory CartState.loaded(List<CartItem> items, double total) =
      CartStateLoaded;
  const factory CartState.error(String message) = CartStateError;
}
