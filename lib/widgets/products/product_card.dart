import 'package:flutter/material.dart';

import './price_tag.dart';

class ProductCard extends StatelessWidget {
    final Map<String, dynamic> product;
    final int productIndex;

    ProductCard(this.product, this.productIndex);

    @override
    Widget build(BuildContext context) =>
        Card(
            child: Column(
                children: <Widget>[
                    Image.asset(product['image']),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Text(
                                    product['title'],
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Oswald',
                                    ),
                                ),
                                SizedBox(width: 8),
                                PriceTag(product['price'].toString()),
                            ],
                        ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2.5,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: Colors.grey,
                                width: 1,
                            ),
                        ),
                        child: Text('Sobradinho II'),
                    ),
                    ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.info),
                                color: Theme.of(context).accentColor,
                                onPressed: () => _navigateTo(productIndex, context: context),
                            ),
                            IconButton(
                                icon: Icon(Icons.favorite_border),
                                color: Colors.red,
                                onPressed: () {},
                            ),
                        ],
                    )
                ],
            ),
        );

    void _navigateTo(index, {final BuildContext context}) {
        Navigator.pushNamed<bool>(
            context,
            '/product/' + index.toString(),
        );
    }
}
