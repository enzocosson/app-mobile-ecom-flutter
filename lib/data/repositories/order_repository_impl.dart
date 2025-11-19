import 'package:hive/hive.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

/// Implémentation du OrderRepository avec Hive pour le stockage local
class OrderRepositoryImpl implements OrderRepository {
  static const String _ordersBoxName = 'orders';
  late Box<OrderModel> _ordersBox;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      _ordersBox = await Hive.openBox<OrderModel>(_ordersBoxName);
      _initialized = true;
    }
  }

  @override
  Future<Order> createOrder(Order order) async {
    await _ensureInitialized();

    final model = OrderModel.fromEntity(order);
    await _ordersBox.put(order.id, model);

    return order;
  }

  @override
  Future<List<Order>> getUserOrders(String userId) async {
    await _ensureInitialized();

    return _ordersBox.values
        .where((model) => model.userId == userId)
        .map((model) => model.toEntity())
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<Order?> getOrder(String orderId) async {
    await _ensureInitialized();

    final model = _ordersBox.get(orderId);
    return model?.toEntity();
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await _ensureInitialized();

    final model = _ordersBox.get(orderId);
    if (model != null) {
      final updatedModel = OrderModel(
        id: model.id,
        userId: model.userId,
        items: model.items,
        total: model.total,
        createdAt: model.createdAt,
        status: status.index,
      );
      await _ordersBox.put(orderId, updatedModel);
    }
  }
}
