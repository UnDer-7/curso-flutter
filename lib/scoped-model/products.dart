import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import './connected_products.dart';

mixin ProductsModel on ConnectedProductsModel {
    bool _showFavorites = false;

    Future<Null> updateProduct(String title,
        String description,
        String image,
        double price,) {
        final Map<String, dynamic> updateData = {
            'title' : title,
            'description' : description,
            'image' : 'https://harald.com.br/wp-content/uploads/2018/02/1Tempera_1000x1000.jpg',
            'price' : price,
            'userEmail' : this.getSelectProduct.userEmail,
            'userID' : this.getSelectProduct.userID,
        };

        this.isLoadingScope = true;
        notifyListeners();

        return http
            .put(
                'https://flutter-products-1c635.firebaseio.com/products/${this.getSelectProduct.id}.json',
                body: json.encode(updateData),
            ).then((http.Response response) {
            final Product updatedProduct = Product(
                id: this.getSelectProduct.id,
                title: title,
                description: description,
                image: image,
                price: price,
                userEmail: getSelectProduct.userEmail,
                userID: getSelectProduct.userID,
            );
                products[selectedProductIndex] = updatedProduct;
                this.isLoadingScope = false;
                notifyListeners();
        });

    }

    void deleteProduct() {
        products.removeAt(selectedProductIndex);
        notifyListeners();
    }

    void fetchProducts() {
        this.isLoadingScope = true;
        notifyListeners();
        http
            .get('https://flutter-products-1c635.firebaseio.com/products.json')
            .then((http.Response response) {
            final Map<String, dynamic> productsListData = json.decode(response.body);
            final List<Product> fetchedProductList = [];

            if (productsListData == null) {
                this.isLoadingScope = false;
                notifyListeners();
                return;
            }

            productsListData.forEach((String productId, dynamic productData) {
                final Product product = Product(
                    id: productId,
                    title: productData['title'],
                    description: productData['description'],
                    image: productData['image'],
                    price: productData['price'],
                    userEmail: productData['userEmail'],
                    userID: productData['userID'],
                );
                fetchedProductList.add(product);
            });

            this.products = fetchedProductList;
            this.isLoadingScope = false;
            notifyListeners();
        });
    }

    void toggleProductFavoriteStatus() {
        final bool isCurrentlyFavorite = getSelectProduct.isFavorite;
        final bool  newFavoriteStatus = !isCurrentlyFavorite;

        final Product updatedProduct = Product(
            title: getSelectProduct.title,
            description: getSelectProduct.description,
            price: getSelectProduct.price,
            image: getSelectProduct.image,
            userEmail: getSelectProduct.userEmail,
            userID: getSelectProduct.userID,
            isFavorite: newFavoriteStatus,
        );

        products[selectedProductIndex] = updatedProduct;
        notifyListeners();
    }

    void toggleDisplayMode() {
        _showFavorites = !_showFavorites;
        notifyListeners();
    }

    List<Product> get allProducts {
        return List.from(products);
    }

    List<Product> get displayedProducts {
        if (_showFavorites) {
            return products
                .where((Product product) => product.isFavorite)
                .toList();
        }
        return List.from(products);
    }

    int get getSelectProductIndex {
        return selectedProductIndex;
    }

    Product get getSelectProduct {
        if (selectedProductIndex == null) {
            return null;
        }
        return products[selectedProductIndex];
    }

    bool get displayFavoritesOnly {
        return _showFavorites;
    }

    set setSelectProductIndex(int index) {
        selectedProductIndex = index;
        notifyListeners();
    }
}
