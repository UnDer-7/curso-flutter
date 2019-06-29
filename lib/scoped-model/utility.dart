import './connected_products.dart';

mixin UtilityModel on ConnectedProductsModel {
    bool get isLoading => this.isLoadingScope;
}
