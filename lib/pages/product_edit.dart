import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';
import '../scoped-model/main.dart';

class ProductEditPage extends StatefulWidget {
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
    ScopedModelDescendant build(BuildContext context) {

        return ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
                final Widget pageContent = _buildPageContent(context, model.getSelectProduct);

                return model.getSelectProductIndex == null ? pageContent :  Scaffold(
                    appBar: AppBar(
                        title: Text('Edit Product'),
                    ),
                    body: pageContent,
                );
            },
        );
    }

    GestureDetector _buildPageContent(BuildContext context, Product product) {
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
                            _buildTitleTextField(product),
                            _buildDescriptionTextField(product),
                            _buildPriceTextField(product),
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
        return ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
                return RaisedButton(
                    child: Text('Save'),
                    onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.getSelectProductIndex),
                );
            },
        );
    }

    EnsureVisibleWhenFocused _buildTitleTextField(Product product) =>
        EnsureVisibleWhenFocused(
            focusNode: _titleFocusNode,
            child: TextFormField(
                focusNode: _titleFocusNode,
                initialValue: product == null ? '' : product.title,
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

    EnsureVisibleWhenFocused _buildDescriptionTextField(Product product) =>
        EnsureVisibleWhenFocused(
            focusNode: _descriptionFocusNode,
            child: TextFormField(
                focusNode: _descriptionFocusNode,
                initialValue: product == null ? '' : product.description,
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

    EnsureVisibleWhenFocused _buildPriceTextField(Product product) =>
        EnsureVisibleWhenFocused(
            focusNode: _priceFocusNode,
            child: TextFormField(
                focusNode: _priceFocusNode,
                initialValue: product == null ? '' : product.price.toString(),
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

    void _submitForm(Function addProduct, Function updateProduct, [int selectedProductIndex]) {
        if (!_formKey.currentState.validate()) return;
        _formKey.currentState.save();

        if (selectedProductIndex == null) {
            addProduct(Product(
                title: _formData['title'],
                description: _formData['description'],
                price: _formData['price'],
                image: _formData['image'],
            ));
        } else {
            updateProduct(Product(
                title: _formData['title'],
                description: _formData['description'],
                price: _formData['price'],
                image: _formData['image'],
            ));
        }

        Navigator.pushReplacementNamed(context, '/products');
    }
}
