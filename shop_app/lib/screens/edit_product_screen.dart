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
  var _isInit = true;
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    description: '',
    id: '',
    imageUrl: '',
    name: '',
    price: 0,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final productId =
          (ModalRoute.of(context)?.settings.arguments ?? '') as String;
      if (productId.isNotEmpty) {
        _editedProduct = Provider.of<Products>(
          context,
          listen: false,
        ).findById(productId);
        _imageController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
  }

  void _saveForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
    }

    if (_editedProduct.id.isEmpty) {
      Provider.of<Products>(
        context,
        listen: false,
      ).addProduct(_editedProduct);
    } else {
      Provider.of<Products>(
        context,
        listen: false,
      ).updateProduct(_editedProduct.id, _editedProduct);
    }
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
                initialValue: _editedProduct.name,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  isFavourite: _editedProduct.isFavourite,
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
                initialValue: _editedProduct.price.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  isFavourite: _editedProduct.isFavourite,
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
                initialValue: _editedProduct.description,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (value) => _editedProduct = Product(
                  id: _editedProduct.id,
                  isFavourite: _editedProduct.isFavourite,
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
                        isFavourite: _editedProduct.isFavourite,
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