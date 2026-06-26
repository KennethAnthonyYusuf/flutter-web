import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../../providers/provider.dart';
import '../../models/models.dart';

class ProductViewModel extends BaseViewModel {

  final ProductStateManager productStateManager = GetIt.instance.get<ProductStateManager>();
  final AppStateManager appStateManager = GetIt.instance.get<AppStateManager>();

  final TextEditingController _search = TextEditingController();
  TextEditingController get searchController => _search;

  Timer? _debounce;

  Future<void> initialize() async{
    _search.text = productStateManager.productSearch.query ?? '';
    productStateManager.addListener(refreshUi);
    appStateManager.addListener(refreshUi);
    await runBusyFuture(productStateManager.initialize());
  }

  void refreshUi(){
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    productStateManager.removeListener(refreshUi);
    appStateManager.removeListener(refreshUi);
    _search.dispose();
    super.dispose();
  }

  Future<void> onSearchChanged(String text) async {
    productStateManager.productSearch = ProductSearch(
      pageNumber: productStateManager.productSearch.pageNumber,
      pageSize: productStateManager.productSearch.pageSize,
      query: text,
    );
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      await runBusyFuture(productStateManager.loadProducts());
    });
  }

  void goToDetail({String? id}) async {
    if (id == null || id.isEmpty) {
      appStateManager.setProductCreate();
    } else {
      appStateManager.setProductEdit(id); 
    }
  }

  bool get canLoadMore => productStateManager.productPageSet?.more == true;

  Future<void> doLoadMore() async {
    if (!canLoadMore) return;

    productStateManager.productSearch = ProductSearch(
      pageNumber: (productStateManager.productSearch.pageNumber ?? 1) + 1,
      pageSize: productStateManager.productSearch.pageSize,
      query: productStateManager.productSearch.query,
    );

    await runBusyFuture(productStateManager.fetchProductDataFromApi(reset: false));
  }

  Future<void> doDelete(String id) async { 
    await runBusyFuture(productStateManager.doDelete(id));
  }

}