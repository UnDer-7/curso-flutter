import 'package:meta/meta.dart';

class Product {
    final String title;
    final String description;
    final double price;
    final String image;
    final bool isFavorite;
    final String userEmail;
    final String userID;

    Product({
        @required this.title,
        @required this.description,
        @required this.price,
        @required this.image,
        @required this.userEmail,
        @required this.userID,
        this.isFavorite = false,
    });
}
