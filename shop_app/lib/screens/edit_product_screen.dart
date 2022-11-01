import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editProduct';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    description: '',
    id: '',
    imageUrl: '',
    name: '',
    price: 0,
  );

  void _saveForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
    }
    Provider.of<Products>(
      context,
      listen: false,
    ).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          )
        ],
        title: Text('Edit product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  name: value as String,
                  description: _editedProduct.description,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                ),
                textInputAction: TextInputAction.next,
                validator: (value) => (value as String).isEmpty
                    ? 'Please provide a value.'
                    : null,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  name: _editedProduct.name,
                  description: _editedProduct.description,
                  price: double.parse(value as String),
                  imageUrl: _editedProduct.imageUrl,
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if ((value as String).isEmpty) {
                    return 'Please enter a price.';
                  } else if (double.parse(value).isNaN) {
                    return 'Please enter a valid number.';
                  } else if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than 0';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  name: _editedProduct.name,
                  description: value as String,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl,
                ),
                validator: (value) => (value as String).isEmpty
                    ? 'Please provide a value.'
                    : null,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    width: 100,
                    child: _imageController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      onEditingComplete: () => setState(() {}),
                      onSaved: (value) => _editedProduct = Product(
                        id: _editedProduct.id,
                        name: _editedProduct.name,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: value as String,
                      ),
                      textInputAction: TextInputAction.done,
                      validator: (value) => (value as String).isEmpty
                          ? 'Please provide a value.'
                          : null,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
