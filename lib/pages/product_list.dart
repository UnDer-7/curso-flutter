import 'package:flutter/material.dart';
import './product_edit.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
    final List<Product> products;
    final Function updateProduct;
    final Function deleteProduct;

    ProductListPage(this.products, this.updateProduct, this.deleteProduct);

    @override
    Widget build(BuildContext context) =>
        ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(products[index].title),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.endToStart) {
                            deleteProduct(index);
                        }
                    },
                    background: Container(
                        color: Colors.red,
                    ),
                    child: Column(
                        children: <Widget>[
                            ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: AssetImage(products[index].image),
                                ),
                                title: Text(products[index].title),
                                subtitle: Text('\$${products[index].price.toString()}'),
                                trailing: _buildEditButton(context, index),
                            ),
                            Divider(),
                        ],
                    ),
                );
            },
        );

    IconButton _buildEditButton(BuildContext context, int index) =>
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProductEditPage(
                        product: products[index],
                        updateProduct: updateProduct,
                        productIndex: index,
                    ),
                ));
            },
        );
}
