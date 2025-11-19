import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_dto.g.dart';

/// DTO pour Product - gère la sérialisation/désérialisation JSON
@JsonSerializable()
class ProductDto {
  final int id;
  final String title;
  final double price;
  final String? thumbnail;
  final List<String>? images;
  final String description;
  final String category;
  final double? rating;
  final int? stock;

  ProductDto({
    required this.id,
    required this.title,
    required this.price,
    this.thumbnail,
    this.images,
    required this.description,
    required this.category,
    this.rating,
    this.stock,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  /// Convertit le DTO en entité métier
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price,
      thumbnail: thumbnail ?? images?.firstOrNull ?? '',
      images: images ?? [thumbnail ?? ''],
      description: description,
      category: category,
      rating: rating,
      stock: stock,
    );
  }

  /// Crée un DTO à partir d'une entité métier
  factory ProductDto.fromEntity(Product product) {
    return ProductDto(
      id: product.id,
      title: product.title,
      price: product.price,
      thumbnail: product.thumbnail,
      images: product.images,
      description: product.description,
      category: product.category,
      rating: product.rating,
      stock: product.stock,
    );
  }
}
