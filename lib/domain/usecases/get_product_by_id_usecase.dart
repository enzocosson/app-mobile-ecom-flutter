import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

/// Use case pour récupérer un produit par son ID
class GetProductByIdUseCase {
  final CatalogRepository _repository;

  GetProductByIdUseCase(this._repository);

  Future<Product?> call(int id) async {
    return await _repository.fetchProduct(id);
  }
}
