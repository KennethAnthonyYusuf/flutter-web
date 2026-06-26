import 'package:sembast/sembast.dart';

import '../../repositories.dart';
import '../../../models/models.dart';
import '../../../constants/constants.dart';

class ProductLocalStorageRepositoryImpl implements ProductLocalStorageRepository {
  final Database db;

  static final StoreRef<int, Map<String, dynamic>> _store =
      intMapStoreFactory.store(SembastConfiguration.productSchema);

  ProductLocalStorageRepositoryImpl({required this.db});

  @override
  Future<List<ProductLocalStorageModel>> getAllProducts() async {
    final records = await _store.find(db);
    return records
        .map((record) => ProductLocalStorageModel.fromJson(record.value))
        .toList();
  }

  @override
  Future<ProductLocalStorageModel> addProduct(ProductLocalStorageModel item) async {
    await _store.add(db, item.toJson());
    return item;
  }

  @override
  Future<List<ProductLocalStorageModel>> addProducts(
    List<ProductLocalStorageModel> items,
  ) async {
    if (items.isEmpty) return items;

    final ids = items.map((e) => e.id).toList();
    if (ids.isEmpty) return items;

    await db.transaction((txn) async {
      final finder = Finder(
        filter: Filter.inList('id', ids),
      );

      await _store.delete(txn, finder: finder);
      await _store.addAll(txn, items.map((e) => e.toJson()).toList());
    });

    return items;
  }

  @override
  Future<void> setProducts(List<ProductLocalStorageModel> items) async {
    await db.transaction((txn) async {
      await _store.delete(txn);
      if (items.isNotEmpty) {
        await _store.addAll(txn, items.map((e) => e.toJson()).toList());
      }
    });
  }

  @override
  Future<void> deleteProduct(String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    await _store.delete(db, finder: finder);
  }

  @override
  Future<void> deleteAllProducts() async {
    await _store.delete(db);
  }
}
