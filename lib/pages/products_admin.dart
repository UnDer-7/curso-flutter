import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';

class ProductAdminPage extends StatelessWidget {
    final Function addProduct;
    final Function deleteProduct;
    final List<Map<String, dynamic>> products;

    ProductAdminPage(this.addProduct, this.deleteProduct, this.products);

    @override
    Widget build(BuildContext context) =>
        DefaultTabController(
            length: 2,
            child: Scaffold(
                drawer: _buildSideDrawer(context),
                appBar: AppBar(
                    title: Text('Manage Products'),
                    bottom: TabBar(
                        tabs: <Widget>[
                            Tab(
                                icon: Icon(Icons.create),
                                text: 'Create Product',
                            ),
                            Tab(
                                icon: Icon(Icons.list),
                                text: 'My Products',
                            ),
                        ],
                    ),
                ),
                body: TabBarView(
                    children: <Widget>[
                      ProductEditPage(addProduct: addProduct,),
                      ProductListPage(products),
                    ],
                ),
            ),
        );

    Drawer _buildSideDrawer(BuildContext context) =>
        Drawer(
            child: Column(
                children: <Widget>[
                    AppBar(
                        automaticallyImplyLeading: false,
                        title: Text('Choose'),
                    ),
                    ListTile(
                        leading: Icon(Icons.shop),
                        title: Text('All Products'),
                        onTap: () {
                            Navigator.pushReplacementNamed(context, '/products');
                        },
                    ),
                ],
            ),
        );
}
