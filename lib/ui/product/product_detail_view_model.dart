import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';

import '../../providers/provider.dart';
import '../../models/models.dart';

class ProductDetailViewModel extends BaseViewModel {

  final ProductStateManager productStateManager = GetIt.instance.get<ProductStateManager>();
  final AppStateManager appStateManager = GetIt.instance.get<AppStateManager>();

  Future<void> initialize(String id) async{

  }

  Future<void> loadDetail(String? id) async {
    await runBusyFuture(productStateManager.loadDetail(id));
  }

  Future<void> doSave(ProductPayload updatedProduct, String? id) async {
    await runBusyFuture(productStateManager.doSave(updatedProduct, id));
    appStateManager.setProduct();
  }

  Future<void> doCancel() async {
    appStateManager.setProduct();
  }

}