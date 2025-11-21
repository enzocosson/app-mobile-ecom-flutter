import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/domain/entities/cart_item.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:app_ecommerce/domain/usecases/get_cart_items_usecase.dart';
import 'package:app_ecommerce/domain/repositories/cart_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CartRepository])
import 'get_cart_items_usecase_test.mocks.dart';

void main() {
  late GetCartItemsUseCase useCase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    useCase = GetCartItemsUseCase(mockRepository);
  });

  group('GetCartItemsUseCase', () {
    final testProduct1 = Product(
      id: 1,
      title: 'Test Product 1',
      price: 99.99,
      thumbnail: 'test1.jpg',
      images: ['test1.jpg'],
      description: 'Test description 1',
      category: 'test',
    );

    final testProduct2 = Product(
      id: 2,
      title: 'Test Product 2',
      price: 149.99,
      thumbnail: 'test2.jpg',
      images: ['test2.jpg'],
      description: 'Test description 2',
      category: 'test',
    );

    final testCartItems = [
      CartItem(product: testProduct1, quantity: 2),
      CartItem(product: testProduct2, quantity: 1),
    ];

    test('should return cart items from repository', () async {
      // Arrange
      when(mockRepository.getCartItems())
          .thenAnswer((_) async => testCartItems);

      // Act
      final result = await useCase();

      // Assert
      expect(result, testCartItems);
      expect(result.length, 2);
      verify(mockRepository.getCartItems()).called(1);
    });

    test('should return empty list when cart is empty', () async {
      // Arrange
      when(mockRepository.getCartItems()).thenAnswer((_) async => []);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isEmpty);
      verify(mockRepository.getCartItems()).called(1);
    });

    test('should preserve cart item quantities', () async {
      // Arrange
      when(mockRepository.getCartItems())
          .thenAnswer((_) async => testCartItems);

      // Act
      final result = await useCase();

      // Assert
      expect(result[0].quantity, 2);
      expect(result[1].quantity, 1);
    });

    test('should preserve product information in cart items', () async {
      // Arrange
      when(mockRepository.getCartItems())
          .thenAnswer((_) async => testCartItems);

      // Act
      final result = await useCase();

      // Assert
      expect(result[0].product.title, 'Test Product 1');
      expect(result[0].product.price, 99.99);
      expect(result[1].product.title, 'Test Product 2');
      expect(result[1].product.price, 149.99);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.getCartItems())
          .thenThrow(Exception('Failed to load cart'));

      // Act & Assert
      expect(
        () async => await useCase(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
