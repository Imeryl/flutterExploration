import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: 15,
                ),
                child: ElevatedButton(
                  onPressed: () => null,
                  child: Text('Order now'),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('£${cart.totalAmount}'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => CartCard(
                id: cart.items.values.toList()[index].id,
                price: cart.items.values.toList()[index].price,
                productId: cart.items.values.toList()[index].productId,
                quantity: cart.items.values.toList()[index].quantity,
              ),
              itemCount: cart.itemCount,
            ),
          ),
        ],
      ),
    );
  }
}
