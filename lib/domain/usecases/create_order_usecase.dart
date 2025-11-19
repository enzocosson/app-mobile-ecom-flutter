import '../entities/order.dart';
import '../repositories/order_repository.dart';

/// Use case pour créer une commande
class CreateOrderUseCase {
  final OrderRepository _repository;

  CreateOrderUseCase(this._repository);

  Future<Order> call(Order order) async {
    if (order.items.isEmpty) {
      throw ArgumentError('La commande ne peut pas être vide');
    }
    return await _repository.createOrder(order);
  }
}
