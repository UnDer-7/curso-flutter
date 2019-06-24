import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-model/products.dart';

class ProductListPage extends StatelessWidget {
    @override
    ScopedModelDescendant build(BuildContext context) =>
        ScopedModelDescendant<ProductsModel>(
            builder: (BuildContext context, Widget child, ProductsModel model) {
                return ListView.builder(
                    itemCount: model.products.length,
                    itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                            key: Key(model.products[index].title),
                            direction: DismissDirection.endToStart,
                            onDismissed: (DismissDirection direction) {
                                if (direction == DismissDirection.endToStart) {
                                    model.setSelectProductIndex = index;
                                    model.deleteProduct();
                                }
                            },
                            background: Container(
                                color: Colors.red,
                            ),
                            child: Column(
                                children: <Widget>[
                                    ListTile(
                                        leading: CircleAvatar(
                                            backgroundImage: AssetImage(model.products[index].image),
                                        ),
                                        title: Text(model.products[index].title),
                                        subtitle: Text('\$${model.products[index].price.toString()}'),
                                        trailing: _buildEditButton(context, index, model),
                                    ),
                                    Divider(),
                                ],
                            ),
                        );
                    },
                );
            },
        );

    IconButton _buildEditButton(BuildContext context, int index, ProductsModel model) =>
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
                model.setSelectProductIndex = index;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProductEditPage(),
                ));
            },
        );
}
