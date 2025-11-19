import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../models/product_dto.dart';

/// Service API pour récupérer les produits
class CatalogApiService {
  static const String _fakeStoreUrl = 'https://fakestoreapi.com/products';
  static const String _localJsonPath = 'assets/data/products.json';

  final http.Client _client;
  final bool useLocalData;

  CatalogApiService({http.Client? client, this.useLocalData = true})
    : _client = client ?? http.Client();

  /// Récupère tous les produits
  Future<List<ProductDto>> fetchProducts() async {
    if (useLocalData) {
      return _fetchLocalProducts();
    }
    return _fetchRemoteProducts();
  }

  /// Récupère un produit par son ID
  Future<ProductDto?> fetchProduct(int id) async {
    final products = await fetchProducts();
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Récupère les produits depuis l'API FakeStore
  Future<List<ProductDto>> _fetchRemoteProducts() async {
    try {
      final response = await _client.get(Uri.parse(_fakeStoreUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => _adaptFakeStoreProduct(json)).toList();
      } else {
        throw Exception(
          'Échec du chargement des produits: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }

  /// Récupère les produits depuis le JSON local
  Future<List<ProductDto>> _fetchLocalProducts() async {
    try {
      final String jsonString = await rootBundle.loadString(_localJsonPath);
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((json) => ProductDto.fromJson(json)).toList();
    } catch (e) {
      // Fallback sur l'API si le JSON local n'existe pas
      return _fetchRemoteProducts();
    }
  }

  /// Adapte le format FakeStore API au format ProductDto
  ProductDto _adaptFakeStoreProduct(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      thumbnail: json['image'],
      images: [json['image']],
      description: json['description'] ?? '',
      category: json['category'] ?? 'other',
      rating: json['rating']?['rate']?.toDouble(),
      stock: 100, // FakeStore n'a pas de stock, on met une valeur par défaut
    );
  }
}
