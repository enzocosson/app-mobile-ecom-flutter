import '../entities/product.dart';

/// Interface du repository pour le catalogue de produits
abstract class CatalogRepository {
  /// Récupère tous les produits
  Future<List<Product>> fetchProducts();

  /// Récupère un produit par son ID
  Future<Product?> fetchProduct(int id);

  /// Recherche des produits par mot-clé
  Future<List<Product>> searchProducts(String query);

  /// Filtre les produits par catégorie
  Future<List<Product>> filterProductsByCategory(String category);

  /// Récupère toutes les catégories disponibles
  Future<List<String>> fetchCategories();
}
