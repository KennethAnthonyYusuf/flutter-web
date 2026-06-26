import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/repositories.dart';
import '../../models/models.dart';

class HomeViewModel extends BaseViewModel {
  final ProductRepository _productRepository = GetIt.instance.get<ProductRepository>();
  ProductSearch productSearch = ProductSearch(pageNumber: 1, pageSize: 10, query: null);
  ProductPageSet? productPageSet;

  void initialize() {
    runBusyFuture(fetchProductDataFromApi());
  }

  Future<void> fetchProductDataFromApi({bool reset = false}) async {
    final page = await _productRepository.searchPage(productSearch);

    productPageSet = page;

    notifyListeners();
  }
}