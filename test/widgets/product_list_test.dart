import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:app_ecommerce/presentation/widgets/product_card.dart';
import 'package:app_ecommerce/presentation/viewmodels/catalog_viewmodel.dart';
import 'package:app_ecommerce/core/providers.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CatalogViewModel])
import 'product_list_test.mocks.dart';

void main() {
  group('Product List Widget Tests', () {
    final testProducts = [
      Product(
        id: 1,
        title: 'iPhone 14',
        price: 999.99,
        thumbnail: 'https://example.com/iphone.jpg',
        images: ['https://example.com/iphone.jpg'],
        description: 'Apple iPhone 14',
        category: 'smartphones',
      ),
      Product(
        id: 2,
        title: 'Samsung Galaxy S23',
        price: 849.99,
        thumbnail: 'https://example.com/samsung.jpg',
        images: ['https://example.com/samsung.jpg'],
        description: 'Samsung Galaxy S23',
        category: 'smartphones',
      ),
      Product(
        id: 3,
        title: 'MacBook Pro',
        price: 1999.99,
        thumbnail: 'https://example.com/macbook.jpg',
        images: ['https://example.com/macbook.jpg'],
        description: 'Apple MacBook Pro',
        category: 'laptops',
      ),
    ];

    testWidgets('should display multiple products in a GridView', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            catalogViewModelProvider.overrideWith((ref) {
              final mockViewModel = MockCatalogViewModel();
              when(mockViewModel.state).thenReturn(CatalogLoaded(testProducts));
              return mockViewModel;
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final catalogState = ref.watch(catalogViewModelProvider);

                  return catalogState.when(
                    initial: () => const Center(child: Text('Initial')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (products) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                          onTap: () {},
                        );
                      },
                    ),
                    error: (message) => Center(child: Text('Error: $message')),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(ProductCard), findsNWidgets(3));
      expect(find.text('iPhone 14'), findsOneWidget);
      expect(find.text('Samsung Galaxy S23'), findsOneWidget);
      expect(find.text('MacBook Pro'), findsOneWidget);
    });

    testWidgets('should display loading indicator when state is loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            catalogViewModelProvider.overrideWith((ref) {
              final mockViewModel = MockCatalogViewModel();
              when(mockViewModel.state).thenReturn(const CatalogLoading());
              return mockViewModel;
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final catalogState = ref.watch(catalogViewModelProvider);

                  return catalogState.when(
                    initial: () => const Center(child: Text('Initial')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (products) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                          onTap: () {},
                        );
                      },
                    ),
                    error: (message) => Center(child: Text('Error: $message')),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(ProductCard), findsNothing);
    });

    testWidgets('should display error message when state is error', (
      WidgetTester tester,
    ) async {
      // Arrange
      const errorMessage = 'Failed to load products';

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            catalogViewModelProvider.overrideWith((ref) {
              final mockViewModel = MockCatalogViewModel();
              when(
                mockViewModel.state,
              ).thenReturn(const CatalogError(errorMessage));
              return mockViewModel;
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final catalogState = ref.watch(catalogViewModelProvider);

                  return catalogState.when(
                    initial: () => const Center(child: Text('Initial')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (products) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                          onTap: () {},
                        );
                      },
                    ),
                    error: (message) => Center(child: Text('Error: $message')),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Assert
      expect(find.text('Error: $errorMessage'), findsOneWidget);
      expect(find.byType(ProductCard), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should display GridView with correct configuration', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            catalogViewModelProvider.overrideWith((ref) {
              final mockViewModel = MockCatalogViewModel();
              when(mockViewModel.state).thenReturn(CatalogLoaded(testProducts));
              return mockViewModel;
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  final catalogState = ref.watch(catalogViewModelProvider);

                  return catalogState.when(
                    initial: () => const Center(child: Text('Initial')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (products) => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                          onTap: () {},
                        );
                      },
                    ),
                    error: (message) => Center(child: Text('Error: $message')),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert
      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
      expect(delegate.childAspectRatio, 0.7);
    });
  });
}
