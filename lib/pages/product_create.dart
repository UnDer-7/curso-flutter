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

    @override
    Widget build(BuildContext context) {
        final double deviceWidth = MediaQuery.of(context).size.width;
        final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
        final double targetPadding = deviceWidth - targetWidth;
        return Container(
            width: targetWidth,
            margin: EdgeInsets.all(10),
            child: ListView(
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
                        color: Theme
                            .of(context)
                            .accentColor,
                        onPressed: _submitFomr,
                    )
                ],
            ),
        );
    }

    TextField _buildTitleTextField() =>
        TextField(
            decoration: InputDecoration(
                labelText: 'Product Title',
            ),
            onChanged: (String value) =>
                setState(() => _titleValue = value),
        );

    TextField _buildDescriptionTextField() =>
        TextField(
            decoration: InputDecoration(
                labelText: 'Product Description',
            ),
            maxLines: 4,
            onChanged: (String value) =>
                setState(() => _descriptionValue = value),
        );

    TextField _buildPriceTextField() =>
        TextField(
            decoration: InputDecoration(
                labelText: 'Product Price',
            ),
            keyboardType: TextInputType.number,
            onChanged: (String value) =>
                setState(() => _priceValue = double.parse(value)),
        );

    void _submitFomr() {
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
