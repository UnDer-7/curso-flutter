import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
    final Function addProduct;

    ProductCreatePage(this.addProduct);

    @override
    State<StatefulWidget> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage>{
    String titleValue;
    String descriptionValue;
    double priceValue;

    @override
    Widget build(BuildContext context) =>
        Container(
            margin: EdgeInsets.all(10),
            child: ListView(
                children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                            labelText: 'Product Title',
                        ),
                        onChanged: (String value) =>
                            setState(() => titleValue = value),
                    ),
                    TextField(
                        decoration: InputDecoration(
                            labelText: 'Product Description',
                        ),
                        maxLines: 4,
                        onChanged: (String value) =>
                            setState(() => descriptionValue = value),
                    ),
                    TextField(
                        decoration: InputDecoration(
                            labelText: 'Product Price',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String value) =>
                            setState(() => priceValue = double.parse(value)),
                    ),
                    SizedBox(
                        height: 10,
                    ),
                    RaisedButton(
                        child: Text('Save'),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                            final Map<String, dynamic> product = {
                                'title': titleValue,
                                'description': descriptionValue,
                                'price': priceValue,
                                'image': 'assets/food.jpg'
                            };
                            widget.addProduct(product);
                            Navigator.pushReplacementNamed(context, '/');
                        },
                    )
                ],
            ),
        );
}
