import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepository {
  // private constructor
  FakeProductsRepository._();
  // making it a singelton with the private constructor
  static FakeProductsRepository instance = FakeProductsRepository._();

  List<Product> getProductsList() {
    return kTestProducts;
  }

  Product? getProduct(String id){
    return kTestProducts.firstWhere((product) => product.id == id);
  }
}