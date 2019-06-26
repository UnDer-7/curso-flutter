import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-model/products.dart';

class Products extends StatelessWidget {
    @override
    ScopedModelDescendant build(BuildContext context) {
        return ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
                return _buildProductList(model.displayedProducts);
            }
        );
    }

    Widget _buildProductList(List<Product> products) {
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
