import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';

import '../../repositories/repositories.dart';
import '../../models/models.dart';

class ProductStateManager extends BaseViewModel {
  final ProductRepository _productRepository = GetIt.instance.get<ProductRepository>();

  ProductPageSet? productPageSet;
  ProductSearch productSearch = ProductSearch(pageNumber: 1, pageSize: 10, query: '');

  final List<ProductPayload> products = [];
  ProductPayload? product;


  bool _initialize = true;

  Future<void> initialize() async {
    product = null;
    if (!_initialize) return;
    _initialize = false;

    await loadProducts();
  }

  Future<void> loadDetail(String? id) async {
    if (id == null || id.isEmpty) {
      return;
    }

    product = await _productRepository.getProductById(id);
  }

  Future<void> loadProducts() async {
    productSearch = ProductSearch(pageNumber: 1, pageSize: 10, query: productSearch.query);
    await fetchProductDataFromApi(reset: true);
  }

  Future<void> fetchProductDataFromApi({bool reset = false}) async {
    final page = await _productRepository.searchPage(productSearch);

    productPageSet = page;

    if (reset) {
      products
        ..clear()
        ..addAll(page.items ?? const []);
    } else {
      products.addAll(page.items ?? const []);
    }

    notifyListeners();
  }

  Future<void> doDelete(String id) async {
    await _productRepository.deleteProduct(id);
    await loadProducts();
  }

  Future<void> doSave (ProductPayload updatedProduct, String? id) async {
    if (id == null) {
      await _productRepository.createProduct(updatedProduct);
    } else {
      await _productRepository.updateProduct(updatedProduct, id);
    }
    await loadProducts();
  }

}
