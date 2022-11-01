import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProduct extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;

  const UserProduct({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => Provider.of<Products>(
                context,
                listen: false,
              ).deleteProduct(id),
            ),
          ],
        ),
      ),
    );
  }
}
