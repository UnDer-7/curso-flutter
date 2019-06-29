import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../models/product.dart';

mixin ConnectedProductsModel on Model {
    @protected
    List<Product> products = [];

    @protected
    int selectedProductIndex;

    @protected
    User authenticatedUser;

    void addProduct(
        String title,
        String description,
        String image,
        double price,
        ) {

        final Map<String, dynamic> productsData = {
            'title' : title,
            'description' : description,
            'image' : 'https://harald.com.br/wp-content/uploads/2018/02/1Tempera_1000x1000.jpg',
            'price' : price,
            'userEmail' : authenticatedUser.email,
            'userID' : authenticatedUser.id,
        };

        http.post(
            'https://flutter-products-1c635.firebaseio.com/products.json',
            body: json.encode(productsData))
            .then((http.Response response) {
                final Map<String, dynamic> responseData = json.decode(response.body);
                print(responseData);
                final Product newProduct = Product(
                    id: responseData['name'],
                    title: title,
                    description: description,
                    image: image,
                    price: price,
                    userEmail: authenticatedUser.email,
                    userID: authenticatedUser.id,
                );
                products.add(newProduct);
                notifyListeners();
        });
    }
}
