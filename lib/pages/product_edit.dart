import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';
import '../scoped_model/products.dart';

class ProductEditPage extends StatefulWidget {
    final Function addProduct;
    final Function updateProduct;
    final int productIndex;
    final Product product;

    ProductEditPage({this.addProduct, this.updateProduct, this.product, this.productIndex});

    @override
    State<StatefulWidget> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage>{
    final Map<String, dynamic> _formData = {
        'title': null,
        'description': null,
        'price': null,
        'image': 'assets/food.jpg',
    };
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final FocusNode _titleFocusNode = FocusNode();
    final FocusNode _descriptionFocusNode = FocusNode();
    final FocusNode _priceFocusNode = FocusNode();

    @override
    Widget build(BuildContext context) {
        final Widget pageContent = _buildPageContent(context);

        return widget.product == null ? pageContent :  Scaffold(
            appBar: AppBar(
                title: Text('Edit Product'),
            ),
            body: pageContent,
        );
    }

    GestureDetector _buildPageContent(BuildContext context) {
        final double deviceWidth = MediaQuery.of(context).size.width;
        final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
        final double targetPadding = deviceWidth - targetWidth;

        return GestureDetector(
            onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
                width: targetWidth,
                margin: EdgeInsets.all(10),
                child: Form(
                    key: _formKey,
                    child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: targetPadding / 2),
                        children: <Widget>[
                            _buildTitleTextField(),
                            _buildDescriptionTextField(),
                            _buildPriceTextField(),
                            SizedBox(
                                height: 10,
                            ),
                            _buildSubmitButton(),
                        ],
                    ),
                ),
            ),
        );
    }

    ScopedModelDescendant _buildSubmitButton() {
        return ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
                return RaisedButton(
                    child: Text('Save'),
                    onPressed: () => _submitForm(model.addProduct, model.updateProduct),
                );
            },
        );
    }

    EnsureVisibleWhenFocused _buildTitleTextField() =>
        EnsureVisibleWhenFocused(
            focusNode: _titleFocusNode,
            child: TextFormField(
                focusNode: _titleFocusNode,
                initialValue: widget.product == null ? '' : widget.product.title,
                onSaved: (String value) => _formData['title'] = value,
                decoration: InputDecoration(
                    labelText: 'Product Title',
                ),
                validator: (String input) {
                    final String value = input.trim();

                    if (value.isEmpty) return 'Title is required';
                    if (value.length < 5) return 'Title should be 5+ characters long';
                },
            ),
        );

    EnsureVisibleWhenFocused _buildDescriptionTextField() =>
        EnsureVisibleWhenFocused(
            focusNode: _descriptionFocusNode,
            child: TextFormField(
                focusNode: _descriptionFocusNode,
                initialValue: widget.product == null ? '' : widget.product.description,
                maxLines: 4,
                onSaved: (String value) => _formData['description'] = value,
                decoration: InputDecoration(
                    labelText: 'Product Description',
                ),
                validator: (String input) {
                    final String value = input.trim();

                    if (value.isEmpty) return 'Description is required';
                    if (value.length < 5) return 'Description should be 5+ characters long';
                },
            ),
        );

    EnsureVisibleWhenFocused _buildPriceTextField() =>
        EnsureVisibleWhenFocused(
            focusNode: _priceFocusNode,
            child: TextFormField(
                focusNode: _priceFocusNode,
                initialValue: widget.product == null ? '' : widget.product.price.toString(),
                keyboardType: TextInputType.number,
                onSaved: (String value) => _formData['price'] = double.parse(value),
                decoration: InputDecoration(
                    labelText: 'Product Price',
                ),
                validator: (String input) {
                    final String value = input.trim();

                    if (value.isEmpty) return 'Description is required';
                    if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) return 'Price should be a number';
                },
            ),
        );

    void _submitForm(Function addProduct, Function updateProduct) {
        if (!_formKey.currentState.validate()) return;
        _formKey.currentState.save();

        if (widget.product == null) {
            addProduct(Product(
                title: _formData['title'],
                description: _formData['description'],
                price: _formData['price'],
                image: _formData['image'],
            ));
        } else {
            updateProduct(widget.productIndex, Product(
                title: _formData['title'],
                description: _formData['description'],
                price: _formData['price'],
                image: _formData['image'],
            ));
        }

        Navigator.pushReplacementNamed(context, '/products');
    }
}
