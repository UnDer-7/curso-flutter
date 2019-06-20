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
                                Container(
                                    child: Text(
                                        '\$${products[index]['price'].toString()}',
                                        style: TextStyle(
                                            color: Colors.white,
                                        ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2.5,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                ),
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
                                onPressed: () => _navigateTo(index, context: context),
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
