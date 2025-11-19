import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

/// Use case pour récupérer tous les produits
class GetProductsUseCase {
  final CatalogRepository _repository;

  GetProductsUseCase(this._repository);

  Future<List<Product>> call() async {
    return await _repository.fetchProducts();
  }
}
