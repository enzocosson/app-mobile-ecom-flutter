import '../entities/cart_item.dart';
import '../entities/product.dart';

/// Interface du repository pour le panier
abstract class CartRepository {
  /// Récupère tous les articles du panier
  Future<List<CartItem>> getCartItems();

  /// Ajoute un produit au panier
  Future<void> addToCart(Product product, {int quantity = 1});

  /// Met à jour la quantité d'un article
  Future<void> updateQuantity(int productId, int quantity);

  /// Supprime un article du panier
  Future<void> removeFromCart(int productId);

  /// Vide le panier
  Future<void> clearCart();

  /// Calcule le total du panier
  Future<double> getCartTotal();
}
