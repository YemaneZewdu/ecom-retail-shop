import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepository {
  // private constructor
  FakeProductsRepository._();
  // making it a singelton with the private constructor
  static FakeProductsRepository instance = FakeProductsRepository._();
  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id){
    return _products.firstWhere((product) => product.id == id);
  }

// this method is suited for REST APIs to get a single response 
// since it's a Future the method name should start with "fetch"
  Future<List<Product>> fetchProductsList(){
    return Future.value(_products);
  }

// this method is suited for Real Time DBm, websocket, ...
// since it's a Stream the method name should start with "watch"
  Stream<List<Product>> watchProductsList() {
      return Stream.value(_products);
  }

// the map will be triggered whenever watchProductsList emits a new value
// this will give a products list to be filtered 
  Stream<Product?> watchProduct(String id){
    return watchProductsList().map((products) => products.firstWhere((product) => product.id == id));
  }
}