import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../scoped-model/main.dart';

class ProductListPage extends StatelessWidget {
    @override
    ScopedModelDescendant build(BuildContext context) =>
        ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
                return ListView.builder(
                    itemCount: model.allProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                            key: Key(model.allProducts[index].title),
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
                                            backgroundImage: AssetImage(model.allProducts[index].image),
                                        ),
                                        title: Text(model.allProducts[index].title),
                                        subtitle: Text('\$${model.allProducts[index].price.toString()}'),
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

    IconButton _buildEditButton(BuildContext context, int index, MainModel model) =>
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
                model.setSelectProductIndex = index;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => ProductEditPage(),
                )).then((_) => model.setSelectProductIndex = null);
            },
        );
}
