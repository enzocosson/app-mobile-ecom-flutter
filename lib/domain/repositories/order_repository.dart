import '../entities/order.dart';

/// Interface du repository pour les commandes
abstract class OrderRepository {
  /// Crée une nouvelle commande
  Future<Order> createOrder(Order order);

  /// Récupère toutes les commandes d'un utilisateur
  Future<List<Order>> getUserOrders(String userId);

  /// Récupère une commande par son ID
  Future<Order?> getOrder(String orderId);

  /// Met à jour le statut d'une commande
  Future<void> updateOrderStatus(String orderId, OrderStatus status);
}
