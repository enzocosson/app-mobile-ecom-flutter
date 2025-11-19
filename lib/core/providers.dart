import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../data/services/catalog_api_service.dart';
import '../data/repositories/catalog_repository_impl.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../data/repositories/order_repository_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/catalog_repository.dart';
import '../domain/repositories/cart_repository.dart';
import '../domain/repositories/order_repository.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/entities/product.dart';
import '../domain/entities/order.dart';
import '../domain/usecases/get_products_usecase.dart';
import '../domain/usecases/get_product_by_id_usecase.dart';
import '../domain/usecases/search_products_usecase.dart';
import '../domain/usecases/add_to_cart_usecase.dart';
import '../domain/usecases/get_cart_items_usecase.dart';
import '../domain/usecases/calculate_cart_total_usecase.dart';
import '../domain/usecases/create_order_usecase.dart';
import '../domain/usecases/get_user_orders_usecase.dart';
import '../presentation/viewmodels/auth_viewmodel.dart';
import '../presentation/viewmodels/catalog_viewmodel.dart';
import '../presentation/viewmodels/cart_viewmodel.dart';

// Exports pour les écrans
export '../presentation/viewmodels/auth_viewmodel.dart';
export '../presentation/viewmodels/catalog_viewmodel.dart';
export '../presentation/viewmodels/cart_viewmodel.dart';
export '../domain/entities/product.dart';
export '../domain/entities/order.dart';
export '../domain/entities/cart_item.dart';

// ==================== Services ====================

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final catalogApiServiceProvider = Provider<CatalogApiService>((ref) {
  return CatalogApiService(
    client: ref.watch(httpClientProvider),
    useLocalData: true, // Utilise le JSON local par défaut
  );
});

// ==================== Repositories ====================

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepositoryImpl(ref.watch(catalogApiServiceProvider));
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl();
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

// ==================== Use Cases ====================

final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(ref.watch(catalogRepositoryProvider));
});

final getProductByIdUseCaseProvider = Provider<GetProductByIdUseCase>((ref) {
  return GetProductByIdUseCase(ref.watch(catalogRepositoryProvider));
});

final searchProductsUseCaseProvider = Provider<SearchProductsUseCase>((ref) {
  return SearchProductsUseCase(ref.watch(catalogRepositoryProvider));
});

final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
  return AddToCartUseCase(ref.watch(cartRepositoryProvider));
});

final getCartItemsUseCaseProvider = Provider<GetCartItemsUseCase>((ref) {
  return GetCartItemsUseCase(ref.watch(cartRepositoryProvider));
});

final calculateCartTotalUseCaseProvider = Provider<CalculateCartTotalUseCase>((
  ref,
) {
  return CalculateCartTotalUseCase(ref.watch(cartRepositoryProvider));
});

final createOrderUseCaseProvider = Provider<CreateOrderUseCase>((ref) {
  return CreateOrderUseCase(ref.watch(orderRepositoryProvider));
});

final getUserOrdersUseCaseProvider = Provider<GetUserOrdersUseCase>((ref) {
  return GetUserOrdersUseCase(ref.watch(orderRepositoryProvider));
});

// ==================== Auth State ====================

final authStateProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

final currentUserProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.currentUser;
});

// ==================== ViewModels ====================

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((
  ref,
) {
  return AuthViewModel(ref.watch(authRepositoryProvider));
});

final catalogViewModelProvider =
    StateNotifierProvider<CatalogViewModel, CatalogState>((ref) {
      return CatalogViewModel(ref);
    });

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>((
  ref,
) {
  return CartViewModel(ref);
});

// Product detail provider
final productByIdProvider = FutureProvider.family<Product?, int>((
  ref,
  id,
) async {
  final useCase = ref.watch(getProductByIdUseCaseProvider);
  return await useCase(id);
});
