import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';

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
        final Product newProduct = Product(
            title: title,
            description: description,
            image: image,
            price: price,
            userEmail: authenticatedUser.email,
            userID: authenticatedUser.id,
        );
        products.add(newProduct);
        notifyListeners();
    }
}
