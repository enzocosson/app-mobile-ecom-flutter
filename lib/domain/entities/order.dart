import 'package:equatable/equatable.dart';
import 'cart_item.dart';

/// Entité Order - Commande utilisateur
class Order extends Equatable {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double total;
  final DateTime createdAt;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [id, userId, items, total, createdAt, status];
}

enum OrderStatus { pending, processing, completed, cancelled }
