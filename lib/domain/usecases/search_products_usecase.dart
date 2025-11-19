import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

/// Use case pour rechercher des produits
class SearchProductsUseCase {
  final CatalogRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<List<Product>> call(String query) async {
    if (query.isEmpty) {
      return await _repository.fetchProducts();
    }
    return await _repository.searchProducts(query);
  }
}
