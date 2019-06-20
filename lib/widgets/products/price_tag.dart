import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
    final String price;

    PriceTag(this.price);

    @override
    Widget build(BuildContext context) =>
        Container(
            child: Text(
                '\$$price',
                style: TextStyle(
                    color: Colors.white,
                ),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2.5,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(5)
            ),
        );
}
