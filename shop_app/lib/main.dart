import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_screen.dart';
import 'screens/products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
        ChangeNotifierProvider(create: (_) => Products()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorSchemeSeed: Color(6770852),
        ),
        home: ProductsScreen(),
        routes: {
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          ProductScreen.routeName: (context) => ProductScreen(),
        },
      ),
    );
  }
}
