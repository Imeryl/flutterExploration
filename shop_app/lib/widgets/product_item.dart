import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;

  const ProductItem({
    required this.id,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: null,
        ),
        title: Text(
          name,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: null,
        ),
      ),
    );
  }
}
