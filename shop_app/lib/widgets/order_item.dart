import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/products.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            subtitle: Text(
              DateFormat('dd/MM/yyyy').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => _expanded = !_expanded),
            ),
            title: Text('£${widget.order.amount}'),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20 + 10, 180),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Provider.of<Products>(
                        context,
                        listen: false,
                      ).findById(widget.order.products[index].productId).name,
                    ),
                    Text(
                      '${widget.order.products[index].quantity} x £${widget.order.products[index].price}',
                      style: TextStyle(fontWeight: FontWeight.w200),
                    )
                  ],
                ),
                itemCount: widget.order.products.length,
              ),
            ),
        ],
      ),
    );
  }
}
