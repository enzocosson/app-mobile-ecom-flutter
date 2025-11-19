import '../entities/cart_item.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

/// Use case pour ajouter un produit au panier
class AddToCartUseCase {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  Future<void> call(Product product, {int quantity = 1}) async {
    if (quantity <= 0) {
      throw ArgumentError('La quantité doit être supérieure à 0');
    }
    await _repository.addToCart(product, quantity: quantity);
  }
}
