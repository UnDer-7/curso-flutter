import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';

class ProductsModel extends Model {
    List<Product> _products = [];
    int _selectedProductIndex;

    void addProduct(Product product) {
        _products.add(product);
        _selectedProductIndex = null;
    }

    void updateProduct(Product product) {
        _products[_selectedProductIndex] = product;
        _selectedProductIndex = null;
    }

    void deleteProduct() {
        _products.removeAt(_selectedProductIndex);
        _selectedProductIndex = null;
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
    }

    List<Product> get products {
        return List.from(_products);
    }

    int get getSelectProductIndex {
        return _selectedProductIndex;
    }

    set setSelectProductIndex(int index) {
        _selectedProductIndex = index;
    }

    Product get getSelectProduct {
        if (_selectedProductIndex == null) {
            return null;
        }
        return _products[_selectedProductIndex];
    }
}
