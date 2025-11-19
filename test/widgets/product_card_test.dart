import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_ecommerce/presentation/widgets/product_card.dart';
import 'package:app_ecommerce/domain/entities/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  group('ProductCard Widget Tests', () {
    final testProduct = Product(
      id: 1,
      title: 'iPhone 14 Pro',
      price: 999.99,
      thumbnail: 'https://example.com/iphone.jpg',
      images: ['https://example.com/iphone.jpg'],
      description: 'Latest iPhone model with advanced features',
      category: 'smartphones',
    );

    testWidgets('should display product title correctly', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('iPhone 14 Pro'), findsOneWidget);
    });

    testWidgets('should display product price correctly', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('\$999.99'), findsOneWidget);
    });

    testWidgets('should display product category correctly', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.text('smartphones'), findsOneWidget);
    });

    testWidgets('should contain a CachedNetworkImage widget', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct, onTap: () {}),
          ),
        ),
      );

      // Assert
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('should call onTap when card is tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(
              product: testProduct,
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      // Assert
      expect(wasTapped, true);
    });

    testWidgets('should have proper Material card styling', (
      WidgetTester tester,
    ) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductCard(product: testProduct, onTap: () {}),
          ),
        ),
      );

      // Assert
      final cardWidget = tester.widget<Card>(find.byType(Card));
      expect(cardWidget.elevation, isNotNull);
    });
  });
}
