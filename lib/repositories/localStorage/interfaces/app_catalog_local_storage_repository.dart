import '../../../models/models.dart';

abstract class ProductLocalStorageRepository {
  Future<List<ProductLocalStorageModel>> getAllProducts();
  Future<ProductLocalStorageModel> addProduct(ProductLocalStorageModel item);
  Future<List<ProductLocalStorageModel>> addProducts(List<ProductLocalStorageModel> items);
  Future<void> setProducts(List<ProductLocalStorageModel> items);
  Future<void> deleteProduct(String id);
  Future<void> deleteAllProducts();
}
