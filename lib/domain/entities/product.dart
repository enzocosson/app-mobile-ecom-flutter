import 'package:equatable/equatable.dart';

/// Entité Product - Modèle métier pour les produits
class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final List<String> images;
  final String description;
  final String category;
  final double? rating;
  final int? stock;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.description,
    required this.category,
    this.rating,
    this.stock,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        thumbnail,
        images,
        description,
        category,
        rating,
        stock,
      ];
}
