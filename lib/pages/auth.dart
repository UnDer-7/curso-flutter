import 'package:flutter/material.dart';

import './products.dart';

class AuthPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: Text('LOGIN'),
        ),
        body: Center(
            child: RaisedButton(
                child: Text('LOGIN'),
                onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProductsPage(),
                        ),);
                },
            ),
        ),
    );
}
