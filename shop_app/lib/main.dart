import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/products.dart';
import 'screens/product_screen.dart';
import 'screens/products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorSchemeSeed: Color(6770852),
        ),
        home: ProductsScreen(),
        routes: {
          ProductScreen.routeName: (context) => ProductScreen(),
        },
      ),
    );
  }
}
