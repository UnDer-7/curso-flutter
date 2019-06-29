import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-model/main.dart';

class ProductsPage extends StatefulWidget {
    final MainModel model;

    ProductsPage(this.model);

    @override
    State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>{
    @override
    void initState() {
        super.initState();
        widget.model.fetchProducts();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
            title: Text('EasyList'),
            actions: <Widget>[
                ScopedModelDescendant<MainModel>(
                    builder: (BuildContext context, Widget child, MainModel model) {
                        return IconButton(
                            icon: Icon(
                                model.displayFavoritesOnly ?
                                Icons.favorite :
                                Icons.favorite_border,
                            ),
                            onPressed: () {
                                model.toggleDisplayMode();
                            },
                        );
                    },
                ),
            ],
        ),
        body: Products(),
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
                        leading: Icon(Icons.edit),
                        title: Text('Manage Products'),
                        onTap: () {
                            Navigator.pushReplacementNamed(context, '/admin');
                        },
                    ),
                ],
            ),
        );
}
