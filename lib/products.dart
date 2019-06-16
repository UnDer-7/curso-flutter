import 'package:flutter/material.dart';

import './pages/product.dart';

class Products extends StatelessWidget {
    final List<Map<String, String>> products;
    final Function deleteProduct;

    Products(this.products, {this.deleteProduct});

    @override
    Widget build(BuildContext context) => _buildProductList();

    Widget _buildProductItem(BuildContext context, int index) {
        return Card(
            child: Column(
                children: <Widget>[
                    Image.asset(products[index]['image']),
                    Text(products[index]['title']),
                    ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                            FlatButton(
                                child: Text('Details'),
                                onPressed: () => {},
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

    void _navigateTo(index, {final BuildContext context, final Widget page}) {
        Navigator.push<bool>(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => page,
            ),
        ).then((bool value) {
            if (value) deleteProduct(index);
        });
    }
}
