import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_product_screen.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(
      context,
      listen: false,
    ).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<Products>(
                  builder: (ctx, productsProvider, _) => Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                      itemBuilder: (context, index) => Column(
                        children: [
                          UserProduct(
                            id: productsProvider.products[index].id,
                            imageUrl: productsProvider.products[index].imageUrl,
                            name: productsProvider.products[index].name,
                          ),
                          Divider(),
                        ],
                      ),
                      itemCount: productsProvider.products.length,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
