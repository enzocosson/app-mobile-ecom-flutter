import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';
import '../../core/providers.dart';

part 'catalog_viewmodel.freezed.dart';

/// ViewModel pour le catalogue de produits
class CatalogViewModel extends StateNotifier<CatalogState> {
  final Ref _ref;

  CatalogViewModel(this._ref) : super(const CatalogState.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = const CatalogState.loading();

    try {
      final useCase = _ref.read(getProductsUseCaseProvider);
      final products = await useCase();
      state = CatalogState.loaded(products);
    } catch (e) {
      state = CatalogState.error(e.toString());
    }
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      loadProducts();
      return;
    }

    state = const CatalogState.loading();

    try {
      final useCase = _ref.read(searchProductsUseCaseProvider);
      final products = await useCase(query);
      state = CatalogState.loaded(products);
    } catch (e) {
      state = CatalogState.error(e.toString());
    }
  }

  Future<void> filterByCategory(String category) async {
    state = const CatalogState.loading();

    try {
      final repo = _ref.read(catalogRepositoryProvider);
      final products = await repo.filterProductsByCategory(category);
      state = CatalogState.loaded(products);
    } catch (e) {
      state = CatalogState.error(e.toString());
    }
  }
}

/// Provider pour CatalogViewModel
final catalogViewModelProvider =
    StateNotifierProvider<CatalogViewModel, CatalogState>((ref) {
  return CatalogViewModel(ref);
});

/// États possibles pour le catalogue
@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState.loading() = CatalogStateLoading;
  const factory CatalogState.loaded(List<Product> products) =
      CatalogStateLoaded;
  const factory CatalogState.error(String message) = CatalogStateError;
}
