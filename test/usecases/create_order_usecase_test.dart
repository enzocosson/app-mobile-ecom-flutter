import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/domain/entities/order.dart';
import 'package:app_ecommerce/domain/entities/cart_item.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:app_ecommerce/domain/usecases/create_order_usecase.dart';
import 'package:app_ecommerce/domain/repositories/order_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrderRepository])
import 'create_order_usecase_test.mocks.dart';

void main() {
  late CreateOrderUseCase useCase;
  late MockOrderRepository mockRepository;

  setUp(() {
    mockRepository = MockOrderRepository();
    useCase = CreateOrderUseCase(mockRepository);
  });

  group('CreateOrderUseCase', () {
    final testProduct = Product(
      id: 1,
      title: 'Test Product',
      price: 99.99,
      thumbnail: 'test.jpg',
      images: ['test.jpg'],
      description: 'Test description',
      category: 'test',
    );

    final testOrder = Order(
      id: '123',
      userId: 'user123',
      items: [CartItem(product: testProduct, quantity: 2)],
      total: 199.98,
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
    );

    test('should create order successfully', () async {
      // Arrange
      when(mockRepository.createOrder(any)).thenAnswer((_) async => testOrder);

      // Act
      final result = await useCase(testOrder);

      // Assert
      expect(result, testOrder);
      verify(mockRepository.createOrder(testOrder)).called(1);
    });

    test('should throw error when order is empty', () async {
      // Arrange
      final emptyOrder = Order(
        id: '123',
        userId: 'user123',
        items: [],
        total: 0,
        createdAt: DateTime.now(),
        status: OrderStatus.pending,
      );

      // Assert
      expect(
        () async => await useCase(emptyOrder),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
