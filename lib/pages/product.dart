import 'dart:async';

import 'package:flutter/material.dart';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
    final String title;
    final String imageUrl;
    final double price;
    final String description;

    ProductPage(this.title, this.imageUrl, this.price, this.description);

    @override
    Widget build(BuildContext context) =>
        WillPopScope(
            onWillPop: () {
                print('back button pressed!');
                Navigator.pop(context, false);
                return Future<bool>.value(false);
            },
            child: Scaffold(
                appBar: AppBar(
                    title: Text(title),
                ),
                body: Column(
                    children: <Widget>[
                        Image.asset(imageUrl),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: TitleDefault(title),
                        ),
                        _buildAddressPriceRow(),
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                                description,
                                textAlign: TextAlign.center,
                            ),
                        ),
                    ],
                ),
            ),
        );

    Row _buildAddressPriceRow() =>
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
