import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

class CartCard extends StatelessWidget {
  final String id;
  final double price;
  final String productId;
  final int quantity;

  const CartCard({
    super.key,
    required this.id,
    required this.price,
    required this.productId,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Dismissible(
      background: Container(
        child: Icon(
          Icons.delete,
        ),
      ),
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      onDismissed: (_) => cart.removeItem(id),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text('${product.name} x${quantity}'),
            trailing: Text('£${(price * quantity)}'),
          ),
        ),
      ),
    );
  }
}
