import 'package:hive/hive.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_item_model.dart';

/// Implémentation du CartRepository avec Hive pour le stockage local
class CartRepositoryImpl implements CartRepository {
  static const String _cartBoxName = 'cart';
  late Box<CartItemModel> _cartBox;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      _cartBox = await Hive.openBox<CartItemModel>(_cartBoxName);
      _initialized = true;
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    await _ensureInitialized();
    return _cartBox.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    await _ensureInitialized();

    // Vérifier si le produit existe déjà dans le panier
    final existingKey = _findProductKey(product.id);

    if (existingKey != null) {
      // Mettre à jour la quantité
      final existingItem = _cartBox.get(existingKey)!;
      final newQuantity = existingItem.quantity + quantity;
      final updatedItem = CartItemModel(
        productId: existingItem.productId,
        productTitle: existingItem.productTitle,
        productPrice: existingItem.productPrice,
        productThumbnail: existingItem.productThumbnail,
        quantity: newQuantity,
        productDescription: existingItem.productDescription,
        productCategory: existingItem.productCategory,
        productImages: existingItem.productImages,
      );
      await _cartBox.put(existingKey, updatedItem);
    } else {
      // Ajouter un nouvel article
      final cartItem = CartItem(product: product, quantity: quantity);
      final model = CartItemModel.fromEntity(cartItem);
      await _cartBox.add(model);
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    await _ensureInitialized();

    if (quantity <= 0) {
      await removeFromCart(productId);
      return;
    }

    final key = _findProductKey(productId);
    if (key != null) {
      final item = _cartBox.get(key)!;
      final updatedItem = CartItemModel(
        productId: item.productId,
        productTitle: item.productTitle,
        productPrice: item.productPrice,
        productThumbnail: item.productThumbnail,
        quantity: quantity,
        productDescription: item.productDescription,
        productCategory: item.productCategory,
        productImages: item.productImages,
      );
      await _cartBox.put(key, updatedItem);
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await _ensureInitialized();

    final key = _findProductKey(productId);
    if (key != null) {
      await _cartBox.delete(key);
    }
  }

  @override
  Future<void> clearCart() async {
    await _ensureInitialized();
    await _cartBox.clear();
  }

  @override
  Future<double> getCartTotal() async {
    await _ensureInitialized();

    double total = 0;
    for (var item in _cartBox.values) {
      total += item.productPrice * item.quantity;
    }
    return total;
  }

  /// Trouve la clé d'un produit dans le panier
  dynamic _findProductKey(int productId) {
    for (var key in _cartBox.keys) {
      final item = _cartBox.get(key);
      if (item?.productId == productId) {
        return key;
      }
    }
    return null;
  }
}
