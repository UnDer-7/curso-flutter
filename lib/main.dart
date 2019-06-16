import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './pages/home.dart';

void main() {
//    debugPaintSizeEnabled = true;
//    debugPaintPointersEnabled = true;
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) => MaterialApp(
//        debugShowMaterialGrid: true,
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
        ),
        home: HomePage(),
    );
}
