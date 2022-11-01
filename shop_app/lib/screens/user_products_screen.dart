import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Your products'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => Column(
            children: [
              UserProduct(
                imageUrl: productsProvider.products[index].imageUrl,
                name: productsProvider.products[index].name,
              ),
              Divider(),
            ],
          ),
          itemCount: productsProvider.products.length,
        ),
      ),
    );
  }
}
