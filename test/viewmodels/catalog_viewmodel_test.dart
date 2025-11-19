import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/presentation/viewmodels/catalog_viewmodel.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:app_ecommerce/domain/usecases/get_products_usecase.dart';
import 'package:app_ecommerce/domain/usecases/search_products_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GetProductsUseCase, SearchProductsUseCase])
import 'catalog_viewmodel_test.mocks.dart';

void main() {
  late CatalogViewModel viewModel;
  late MockGetProductsUseCase mockGetProductsUseCase;
  late MockSearchProductsUseCase mockSearchProductsUseCase;

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    mockSearchProductsUseCase = MockSearchProductsUseCase();
  });

  group('CatalogViewModel', () {
    final testProducts = [
      Product(
        id: 1,
        title: 'iPhone 14',
        price: 999.99,
        thumbnail: 'iphone.jpg',
        images: ['iphone.jpg'],
        description: 'Apple iPhone 14',
        category: 'smartphones',
      ),
      Product(
        id: 2,
        title: 'MacBook Pro',
        price: 1999.99,
        thumbnail: 'macbook.jpg',
        images: ['macbook.jpg'],
        description: 'Apple MacBook Pro',
        category: 'laptops',
      ),
    ];

    test(
      'loadProducts should emit loading then loaded states on success',
      () async {
        // Arrange
        when(mockGetProductsUseCase()).thenAnswer((_) async => testProducts);

        viewModel = CatalogViewModel(
          mockGetProductsUseCase,
          mockSearchProductsUseCase,
        );

        // Wait for constructor to complete loading
        await Future.delayed(Duration(milliseconds: 100));

        // Assert
        expect(viewModel.debugState, isA<CatalogLoaded>());
        final loadedState = viewModel.debugState as CatalogLoaded;
        expect(loadedState.products.length, 2);
        expect(loadedState.products, testProducts);
      },
    );

    test('loadProducts should emit error state on failure', () async {
      // Arrange
      const errorMessage = 'Failed to load products';
      when(mockGetProductsUseCase()).thenThrow(Exception(errorMessage));

      viewModel = CatalogViewModel(
        mockGetProductsUseCase,
        mockSearchProductsUseCase,
      );

      // Wait for constructor to complete loading
      await Future.delayed(Duration(milliseconds: 100));

      // Assert
      expect(viewModel.debugState, isA<CatalogError>());
      final errorState = viewModel.debugState as CatalogError;
      expect(errorState.message, contains(errorMessage));
    });

    test('searchProducts should filter products by query', () async {
      // Arrange
      when(mockGetProductsUseCase()).thenAnswer((_) async => testProducts);
      when(
        mockSearchProductsUseCase(any),
      ).thenAnswer((_) async => [testProducts[0]]);

      viewModel = CatalogViewModel(
        mockGetProductsUseCase,
        mockSearchProductsUseCase,
      );

      // Wait for constructor to complete
      await Future.delayed(Duration(milliseconds: 100));

      // Act
      await viewModel.searchProducts('iPhone');

      // Assert
      expect(viewModel.debugState, isA<CatalogLoaded>());
      final loadedState = viewModel.debugState as CatalogLoaded;
      expect(loadedState.products.length, 1);
      expect(loadedState.products[0].title, 'iPhone 14');
      verify(mockSearchProductsUseCase('iPhone')).called(1);
    });

    test('filterByCategory should load products for given category', () async {
      // Arrange
      final laptops = [testProducts[1]];
      when(mockGetProductsUseCase()).thenAnswer((_) async => testProducts);
      when(mockSearchProductsUseCase(any)).thenAnswer((_) async => laptops);

      viewModel = CatalogViewModel(
        mockGetProductsUseCase,
        mockSearchProductsUseCase,
      );

      // Wait for constructor to complete
      await Future.delayed(Duration(milliseconds: 100));

      // Act
      await viewModel.filterByCategory('laptops');

      // Assert
      expect(viewModel.debugState, isA<CatalogLoaded>());
      final loadedState = viewModel.debugState as CatalogLoaded;
      expect(loadedState.products.length, 1);
      expect(loadedState.products[0].category, 'laptops');
    });
  });
}
