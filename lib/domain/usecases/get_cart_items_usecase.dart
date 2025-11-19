import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

/// Use case pour récupérer les articles du panier
class GetCartItemsUseCase {
  final CartRepository _repository;

  GetCartItemsUseCase(this._repository);

  Future<List<CartItem>> call() async {
    return await _repository.getCartItems();
  }
}
