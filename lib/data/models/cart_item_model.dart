import 'package:hive/hive.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';

part 'cart_item_model.g.dart';

/// Modèle Hive pour CartItem - stockage local
@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
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

  CartItemModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productThumbnail,
    required this.quantity,
    required this.productDescription,
    required this.productCategory,
    required this.productImages,
  });

  /// Convertit le modèle en entité métier
  CartItem toEntity() {
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

  /// Crée un modèle à partir d'une entité métier
  factory CartItemModel.fromEntity(CartItem cartItem) {
    return CartItemModel(
      productId: cartItem.product.id,
      productTitle: cartItem.product.title,
      productPrice: cartItem.product.price,
      productThumbnail: cartItem.product.thumbnail,
      quantity: cartItem.quantity,
      productDescription: cartItem.product.description,
      productCategory: cartItem.product.category,
      productImages: cartItem.product.images,
    );
  }
}
