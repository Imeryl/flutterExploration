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
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );
    final product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);

    return Dismissible(
      background: ColoredBox(
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
        color: Theme.of(context).colorScheme.error,
      ),
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
          title: Text('Are you sure?'),
          content: Text('Do you want to remove the item from the cart?'),
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
            trailing: Text('£${(price * quantity).toStringAsFixed(2)}'),
          ),
        ),
      ),
    );
  }
}
