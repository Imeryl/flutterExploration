import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_card.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;

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
                  onPressed: cart.totalAmount <= 0 || _isLoading
                      ? null
                      : () {
                          setState(() => _isLoading = true);
                          Provider.of<Orders>(
                            context,
                            listen: false,
                          )
                              .addOrder(
                            cart.items.values.toList(),
                            cart.totalAmount,
                          )
                              .then(
                            (value) {
                              setState(() => _isLoading = false);
                              cart.clearCart();
                            },
                          );
                        },
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text('Order now'),
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
                    label: Text('£${cart.totalAmount.toStringAsFixed(2)}'),
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
