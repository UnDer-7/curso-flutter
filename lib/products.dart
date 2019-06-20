import 'package:flutter/material.dart';

class Products extends StatelessWidget {
    final List<Map<String, dynamic>> products;

    Products(this.products);

    @override
    Widget build(BuildContext context) => _buildProductList();

    Widget _buildProductItem(BuildContext context, int index) {
        return Card(
            child: Column(
                children: <Widget>[
                    Image.asset(products[index]['image']),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Text(
                                    products[index]['title'],
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Oswald',
                                    ),
                                ),
                                SizedBox(width: 8),
                                Text(products[index]['price'].toString()),
                            ],
                        ),
                    ),
                    ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                            FlatButton(
                                child: Text('Details'),
                                onPressed: () => _navigateTo(index, context: context),
                            ),
                        ],
                    )
                ],
            ),
        );
    }

    Widget _buildProductList() {
        Widget productCard = Center(child: Text('No Products found!'));

        if (products.length > 0) {
            productCard = ListView.builder(
                itemBuilder: _buildProductItem,
                itemCount: products.length,
            );
        }

        return productCard;
    }

    void _navigateTo(index, {final BuildContext context}) {
        Navigator.pushNamed<bool>(
            context,
            '/product/' + index.toString(),
        );
    }
}
