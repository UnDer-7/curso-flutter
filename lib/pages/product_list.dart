import 'package:flutter/material.dart';
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
    final List<Map<String, dynamic>> products;

    ProductListPage(this.products);

    @override
    Widget build(BuildContext context) =>
        ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Image.asset(products[index]['image']),
                    title: Text(products[index]['title']),
                    trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => ProductEditPage(product: products[index]),
                            ));
                        },
                    ),
                );
            },
        );
}
