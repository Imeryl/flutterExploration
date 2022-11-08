import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../screens/product_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ProductScreen.routeName,
          arguments: product.id,
        ),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: Consumer<Product>(
          builder: (context, value, child) => IconButton(
            icon: Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_border,
            ),
            onPressed: () => Provider.of<Products>(
              context,
              listen: false,
            ).toggleFavourite(product.id),
          ),
        ),
        title: Text(
          product.name,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            cart.addItem(product.id, product.price);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () => cart.removeSingleItem(product.id),
                ),
                content: Text('Added item to cart'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}
