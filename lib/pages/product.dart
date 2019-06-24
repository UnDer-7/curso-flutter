import 'dart:async';

import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../scoped-model/products.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
    final int productIndex;

    ProductPage(this.productIndex);

    @override
    WillPopScope build(BuildContext context) =>
        WillPopScope(
            onWillPop: () {
                print('back button pressed!');
                Navigator.pop(context, false);
                return Future<bool>.value(false);
            },
            child: ScopedModelDescendant<ProductsModel>(
                builder: (BuildContext context, Widget child, ProductsModel model) {
                    final Product products = model.products[productIndex];

                    return Scaffold(
                        appBar: AppBar(
                            title: Text(products.title),
                        ),
                        body: Column(
                            children: <Widget>[
                                Image.asset(products.image),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: TitleDefault(products.title),
                                ),
                                _buildAddressPriceRow(products.price),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        products.description    ,
                                        textAlign: TextAlign.center,
                                    ),
                                ),
                            ],
                        ),
                    );
                },
            ),
        );

    Row _buildAddressPriceRow(double price) =>
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(
                    'Sobradinho II',
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        color: Colors.grey,
                    ),
                ),
                Container(
                    child: Text(
                        '|',
                        style: TextStyle(
                            color: Colors.grey,
                        ),
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: 5
                    ),
                ),
                Text(
                    '\$' + price.toString(),
                    style: TextStyle(
                        fontFamily: 'Oswald',
                        color: Colors.grey,
                    ),
                ),
            ],
        );
}
