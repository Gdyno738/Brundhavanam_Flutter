import 'package:brundhavanam_app/providers/cart_provider.dart';
import 'package:brundhavanam_app/providers/wish_list_provider.dart';
import 'package:brundhavanam_app/screens/navigation/main_navigation.dart';
import 'package:brundhavanam_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// 🔥 KEY IS THE FIX
      home: SplashScreen()
    );
  }
}
