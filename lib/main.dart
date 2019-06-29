import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './models/product.dart';
import './scoped-model/main.dart';

void main() {
//    debugPaintSizeEnabled = true;
//    debugPaintPointersEnabled = true;
    runApp(MyApp());
}

class MyApp extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _MyAppState();
    }
}

class _MyAppState extends State<MyApp> {
    List<Product> _products = [];

    @override
    ScopedModel build(BuildContext context) {
        final MainModel model = MainModel();

        return ScopedModel<MainModel>(
            model: model,
            child: MaterialApp(
//        debugShowMaterialGrid: true,
                theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    accentColor: Colors.orange,
                    buttonColor: Colors.orange,
                ),
//        home: AuthPage(),
                routes: {
                    '/': (BuildContext context) => AuthPage(),
                    '/products': (BuildContext context) => ProductsPage(model),
                    '/admin': (BuildContext context) => ProductAdminPage(),
                },
                onGenerateRoute: (RouteSettings settings) {
                    final List<String> pathElements = settings.name.split('/');

                    if (pathElements[0] != '') return null;

                    if (pathElements[1] == 'product') {
                        final int index = int.parse(pathElements[2]);
                        return MaterialPageRoute<bool>(
                            builder: (BuildContext context) =>
                                ProductPage(index),
                        );
                    }

                    return null;
                },
                onUnknownRoute: (RouteSettings settings) {
                    return MaterialPageRoute(
                        builder: (BuildContext context) => ProductsPage(model),
                    );
                },
            ),
        );
    }

}
