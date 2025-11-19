import 'package:hive/hive.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';

part 'order_model.g.dart';

/// Modèle Hive pour Order - stockage local
@HiveType(typeId: 1)
class OrderModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final List<CartItemData> items;

  @HiveField(3)
  final double total;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final int status;

  OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.createdAt,
    required this.status,
  });

  /// Convertit le modèle en entité métier
  Order toEntity() {
    return Order(
      id: id,
      userId: userId,
      items: items.map((item) => item.toCartItem()).toList(),
      total: total,
      createdAt: createdAt,
      status: OrderStatus.values[status],
    );
  }

  /// Crée un modèle à partir d'une entité métier
  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      userId: order.userId,
      items: order.items
          .map((item) => CartItemData.fromCartItem(item))
          .toList(),
      total: order.total,
      createdAt: order.createdAt,
      status: order.status.index,
    );
  }
}

/// Classe pour stocker les données d'un CartItem
@HiveType(typeId: 2)
class CartItemData {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productTitle;

  @HiveField(2)
  final double productPrice;

  @HiveField(3)
  final String productThumbnail;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final String productDescription;

  @HiveField(6)
  final String productCategory;

  @HiveField(7)
  final List<String> productImages;

  CartItemData({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productThumbnail,
    required this.quantity,
    required this.productDescription,
    required this.productCategory,
    required this.productImages,
  });

  CartItem toCartItem() {
    return CartItem(
      product: Product(
        id: productId,
        title: productTitle,
        price: productPrice,
        thumbnail: productThumbnail,
        images: productImages,
        description: productDescription,
        category: productCategory,
      ),
      quantity: quantity,
    );
  }

  factory CartItemData.fromCartItem(CartItem item) {
    return CartItemData(
      productId: item.product.id,
      productTitle: item.product.title,
      productPrice: item.product.price,
      productThumbnail: item.product.thumbnail,
      quantity: item.quantity,
      productDescription: item.product.description,
      productCategory: item.product.category,
      productImages: item.product.images,
    );
  }
}
