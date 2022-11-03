import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() => _isLoading = true);
      Provider.of<Orders>(
        context,
        listen: false,
      ).fetchOrders().then((value) => setState(() => _isLoading = false));
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  OrderItem(orderProvider.orders[index]),
              itemCount: orderProvider.orders.length,
            ),
    );
  }
}
