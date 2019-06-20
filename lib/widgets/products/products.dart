import 'package:flutter/material.dart';

import './product_card.dart';

class Products extends StatelessWidget {
    final List<Map<String, dynamic>> products;

    Products(this.products);

    @override
    Widget build(BuildContext context) => _buildProductList();


    Widget _buildProductList() {
        Widget productCard = Center(child: Text('No Products found!'));

        if (products.length > 0) {
            productCard = ListView.builder(
                itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
                itemCount: products.length,
            );
        }

        return productCard;
    }


}