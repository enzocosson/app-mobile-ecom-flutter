import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'presentation/router.dart';
import 'data/models/cart_item_model.dart';
import 'data/models/order_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialiser Hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(CartItemDataAdapter());

  runApp(const ProviderScope(child: ShopFlutterApp()));
}

class ShopFlutterApp extends ConsumerWidget {
  const ShopFlutterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'ShopFlutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
