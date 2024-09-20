import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {


  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    // fake delay to get the loading state
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});


final productsListStreamProvider = StreamProvider<List<Product>>((ref) {
  // we can use the ref object wheather or not we are inside a widget or provider
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProductsList();
});

final productsListFutureProvider = FutureProvider<List<Product>>((ref) {
  // we can use the ref object wheather or not we are inside a widget or provider
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.fetchProductsList();
});

// the "String" is the type of the argument
// family provider is used when we need to pass an dynamic argument to a provider
 final productProvider = StreamProvider.family<Product?, String>((ref, id)  {
   final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProduct(id);
});