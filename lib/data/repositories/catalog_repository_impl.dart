import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../services/catalog_api_service.dart';
import '../models/product_dto.dart';

/// Implémentation du CatalogRepository
class CatalogRepositoryImpl implements CatalogRepository {
  final CatalogApiService _apiService;
  List<Product>? _cachedProducts;
  DateTime? _lastFetchTime;
  static const Duration _cacheExpiration = Duration(minutes: 30);

  CatalogRepositoryImpl(this._apiService);

  @override
  Future<List<Product>> fetchProducts() async {
    // Vérifier le cache
    if (_cachedProducts != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!) < _cacheExpiration) {
      return _cachedProducts!;
    }

    // Récupérer depuis l'API
    final productsDto = await _apiService.fetchProducts();
    _cachedProducts = productsDto.map((dto) => dto.toEntity()).toList();
    _lastFetchTime = DateTime.now();

    return _cachedProducts!;
  }

  @override
  Future<Product?> fetchProduct(int id) async {
    // Vérifier d'abord le cache
    if (_cachedProducts != null) {
      try {
        return _cachedProducts!.firstWhere((p) => p.id == id);
      } catch (e) {
        // Continue vers l'API
      }
    }

    final productDto = await _apiService.fetchProduct(id);
    return productDto?.toEntity();
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final products = await fetchProducts();
    final lowerQuery = query.toLowerCase();

    return products.where((product) {
      return product.title.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<List<Product>> filterProductsByCategory(String category) async {
    final products = await fetchProducts();
    return products
        .where(
          (product) => product.category.toLowerCase() == category.toLowerCase(),
        )
        .toList();
  }

  @override
  Future<List<String>> fetchCategories() async {
    final products = await fetchProducts();
    final categories = products.map((p) => p.category).toSet().toList();
    categories.sort();
    return categories;
  }
}
