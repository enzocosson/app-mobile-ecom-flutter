import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:app_ecommerce/domain/usecases/search_products_usecase.dart';
import 'package:app_ecommerce/domain/repositories/catalog_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CatalogRepository])
import 'search_products_usecase_test.mocks.dart';

void main() {
  late SearchProductsUseCase useCase;
  late MockCatalogRepository mockRepository;

  setUp(() {
    mockRepository = MockCatalogRepository();
    useCase = SearchProductsUseCase(mockRepository);
  });

  group('SearchProductsUseCase', () {
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
        title: 'Samsung Galaxy',
        price: 849.99,
        thumbnail: 'samsung.jpg',
        images: ['samsung.jpg'],
        description: 'Samsung Galaxy S23',
        category: 'smartphones',
      ),
    ];

    test('should return filtered products when query is provided', () async {
      // Arrange
      when(
        mockRepository.searchProducts(any),
      ).thenAnswer((_) async => [testProducts[0]]);

      // Act
      final result = await useCase('iPhone');

      // Assert
      expect(result.length, 1);
      expect(result[0].title, contains('iPhone'));
      verify(mockRepository.searchProducts('iPhone')).called(1);
    });

    test('should return all products when query is empty', () async {
      // Arrange
      when(
        mockRepository.fetchProducts(),
      ).thenAnswer((_) async => testProducts);

      // Act
      final result = await useCase('');

      // Assert
      expect(result.length, 2);
      verify(mockRepository.fetchProducts()).called(1);
      verifyNever(mockRepository.searchProducts(any));
    });
  });
}
