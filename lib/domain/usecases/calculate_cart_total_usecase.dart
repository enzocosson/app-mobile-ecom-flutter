import '../repositories/cart_repository.dart';

/// Use case pour calculer le total du panier
class CalculateCartTotalUseCase {
  final CartRepository _repository;

  CalculateCartTotalUseCase(this._repository);

  Future<double> call() async {
    return await _repository.getCartTotal();
  }
}
