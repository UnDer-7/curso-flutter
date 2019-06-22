import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
    final Function addProduct;

    ProductCreatePage(this.addProduct);

    @override
    State<StatefulWidget> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage>{
    String _titleValue;
    String _descriptionValue;
    double _priceValue;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
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
    }

    TextFormField _buildTitleTextField() =>
        TextFormField(
            decoration: InputDecoration(
                labelText: 'Product Title',
            ),
            validator: (String input) {
                final String value = input.trim();

                if (value.isEmpty) return 'Title is required';
                if (value.length < 5) return 'Title should be 5+ characters long';
            },
            onSaved: (String value) => setState(() => _titleValue = value),
        );

    TextFormField _buildDescriptionTextField() =>
        TextFormField(
            decoration: InputDecoration(
                labelText: 'Product Description',
            ),
            maxLines: 4,
            onSaved: (String value) => setState(() => _descriptionValue = value),
            validator: (String input) {
                final String value = input.trim();

                if (value.isEmpty) return 'Description is required';
                if (value.length < 5) return 'Description should be 5+ characters long';
            },
        );

    TextFormField _buildPriceTextField() =>
        TextFormField(
            decoration: InputDecoration(
                labelText: 'Product Price',
            ),
            keyboardType: TextInputType.number,
            onSaved: (String value) => setState(() => _priceValue = double.parse(value)),
            validator: (String input) {
                final String value = input.trim();

                if (value.isEmpty) return 'Description is required';
                if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) return 'Price should be a number';
            },
        );

    void _submitForm() {
        if (!_formKey.currentState.validate()) return;
        _formKey.currentState.save();
        final Map<String, dynamic> product = {
            'title': _titleValue,
            'description': _descriptionValue,
            'price': _priceValue,
            'image': 'assets/food.jpg'
        };
        widget.addProduct(product);
        Navigator.pushReplacementNamed(context, '/products');
    }
}
