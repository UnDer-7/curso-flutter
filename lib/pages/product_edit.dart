import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
    final Function addProduct;
    final Function updateProduct;
    final Map<String, dynamic> product;

    ProductEditPage({this.addProduct, this.updateProduct, this.product});

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

    @override
    Widget build(BuildContext context) {
        final double deviceWidth = MediaQuery.of(context).size.width;
        final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
        final double targetPadding = deviceWidth - targetWidth;
        final Widget pageContent = GestureDetector(
            onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
                width: targetWidth,
                margin: EdgeInsets.all(10),
                child: Form(
                    key: _formKey,
                    child:ListView(
                        padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                        children: <Widget>[
                            _buildTitleTextField(),
                            _buildDescriptionTextField(),
                            _buildPriceTextField(),
                            SizedBox(
                                height: 10,
                            ),
                            RaisedButton(
                                child: Text('Save'),
                                onPressed: _submitForm,
                            )
                        ],
                    ),
                ),
            ),
        );

        return widget.product == null ? pageContent :  Scaffold(
            appBar: AppBar(
                title: Text('Edit Product'),
            ),
            body: pageContent,
        );
    }

    TextFormField _buildTitleTextField() =>
        TextFormField(
            initialValue: widget.product == null ? '' : widget.product['title'],
            onSaved: (String value) => _formData['title'] = value,
            decoration: InputDecoration(
                labelText: 'Product Title',
            ),
            validator: (String input) {
                final String value = input.trim();

                if (value.isEmpty) return 'Title is required';
                if (value.length < 5) return 'Title should be 5+ characters long';
            },
        );

    TextFormField _buildDescriptionTextField() =>
        TextFormField(
            initialValue: widget.product == null ? '' : widget.product['description'],
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
        );

    TextFormField _buildPriceTextField() =>
        TextFormField(
            initialValue: widget.product == null ? '' : widget.product['price'].toString(),
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
        );

    void _submitForm() {
        if (!_formKey.currentState.validate()) return;
        _formKey.currentState.save();

        widget.addProduct(_formData);
        Navigator.pushReplacementNamed(context, '/products');
    }
}
