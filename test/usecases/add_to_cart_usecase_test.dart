import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:app_ecommerce/domain/usecases/add_to_cart_usecase.dart';
import 'package:app_ecommerce/domain/repositories/cart_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CartRepository])
import 'add_to_cart_usecase_test.mocks.dart';

void main() {
  late AddToCartUseCase useCase;
  late MockCartRepository mockRepository;

  setUp(() {
    mockRepository = MockCartRepository();
    useCase = AddToCartUseCase(mockRepository);
  });

  group('AddToCartUseCase', () {
    final testProduct = Product(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      thumbnail: 'test.jpg',
      images: ['test.jpg'],
      description: 'Test description',
      category: 'test',
    );

    test('should add product to cart with default quantity', () async {
      // Arrange
      when(
        mockRepository.addToCart(any, quantity: anyNamed('quantity')),
      ).thenAnswer((_) async => {});

      // Act
      await useCase(testProduct);

      // Assert
      verify(mockRepository.addToCart(testProduct, quantity: 1)).called(1);
    });

    test('should add product to cart with custom quantity', () async {
      // Arrange
      when(
        mockRepository.addToCart(any, quantity: anyNamed('quantity')),
      ).thenAnswer((_) async => {});

      // Act
      await useCase(testProduct, quantity: 5);

      // Assert
      verify(mockRepository.addToCart(testProduct, quantity: 5)).called(1);
    });

    test('should throw error when quantity is zero', () async {
      // Assert
      expect(
        () async => await useCase(testProduct, quantity: 0),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw error when quantity is negative', () async {
      // Assert
      expect(
        () async => await useCase(testProduct, quantity: -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
