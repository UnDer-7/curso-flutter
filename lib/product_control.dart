import 'package:flutter/material.dart';

class ProductCrontrol extends StatelessWidget {
    final Function addProduct;

    ProductCrontrol(this.addProduct);

    @override
    Widget build(BuildContext context) {
        return  RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
                addProduct({'title': 'Chocalate', 'image': 'assets/food.jpg'});
            },
            child: Text('ADD PRODUCT'),
        );
    }
}
