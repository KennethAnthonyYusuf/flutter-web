import '../../models/models.dart';

abstract class ProductRepository {
  Future<ProductPayload> getProductById(String id);
  Future<List<ProductPayload>> getAllProducts();
  Future<ProductPayload> createProduct(ProductPayload product);
  Future<ProductPayload> updateProduct(ProductPayload product, String id);
  Future<void> deleteProduct(String id);
  Future<ProductPageSet> searchPage(ProductSearch payload);
}
