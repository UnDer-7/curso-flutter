import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

mixin ProductsModel on Model {
    List<Product> _products = [];
    int _selectedProductIndex;
    bool _showFavorites = false;

    void addProduct(Product product) {
        _products.add(product);
        _selectedProductIndex = null;
        notifyListeners();
    }

    void updateProduct(Product product) {
        _products[_selectedProductIndex] = product;
        _selectedProductIndex = null;
        notifyListeners();
    }

    void deleteProduct() {
        _products.removeAt(_selectedProductIndex);
        _selectedProductIndex = null;
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
            isFavorite: newFavoriteStatus,
        );

        _products[_selectedProductIndex] = updatedProduct;
        _selectedProductIndex = null;
        notifyListeners();
    }

    void toggleDisplayMode() {
        _showFavorites = !_showFavorites;
        notifyListeners();
    }

    List<Product> get products {
        return List.from(_products);
    }

    List<Product> get displayedProducts {
        if (_showFavorites) {
            return _products
                .where((Product product) => product.isFavorite)
                .toList();
        }
        return List.from(_products);
    }

    int get getSelectProductIndex {
        return _selectedProductIndex;
    }

    Product get getSelectProduct {
        if (_selectedProductIndex == null) {
            return null;
        }
        return _products[_selectedProductIndex];
    }

    bool get displayFavoritesOnly {
        return _showFavorites;
    }

    set setSelectProductIndex(int index) {
        _selectedProductIndex = index;
        notifyListeners();
    }
}
