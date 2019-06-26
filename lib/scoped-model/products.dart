import '../models/product.dart';
import './connected_products.dart';

mixin ProductsModel on ConnectedProducts {
    bool _showFavorites = false;

    void updateProduct(String title,
        String description,
        String image,
        double price,) {
        final Product updatedProduct = Product(
            title: title,
            description: description,
            image: image,
            price: price,
            userEmail: getSelectProduct.userEmail,
            userID: getSelectProduct.userID,
        );

        products[selectedProductIndex] = updatedProduct;
        selectedProductIndex = null;
        notifyListeners();
    }

    void deleteProduct() {
        products.removeAt(selectedProductIndex);
        selectedProductIndex = null;
        notifyListeners();
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
        selectedProductIndex = null;
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
