import '../entities/order.dart';
import '../repositories/order_repository.dart';

/// Use case pour récupérer les commandes d'un utilisateur
class GetUserOrdersUseCase {
  final OrderRepository _repository;

  GetUserOrdersUseCase(this._repository);

  Future<List<Order>> call(String userId) async {
    return await _repository.getUserOrders(userId);
  }
}
