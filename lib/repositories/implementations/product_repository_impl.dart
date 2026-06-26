import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../repositories.dart';
import '../../models/models.dart';

class ProductRepositoryImpl extends RestApiRepositoryBase
    implements ProductRepository {
  ProductRepositoryImpl({super.base});

  final ProductLocalStorageRepository _local =
        GetIt.instance<ProductLocalStorageRepository>();

  @override
  Future<ProductPayload> getProductById(String id) async {
    final cachedList = await _local.getAllProducts();
    final cached = cachedList.where((p) => p.id == id).toList();

    if (cached.isNotEmpty) {
      debugPrint('CACHE HIT: $id');
      return ProductPayload.fromLocal(cached.first);
    }

    final map = await get('/products/$id');
    debugPrint('GET response: $map');

    final fresh = ProductPayload.fromJson(map);

    await _local.addProduct(
      ProductLocalStorageModel.fromProduct(fresh),
    );

    return fresh;
  }

  @override
  Future<List<ProductPayload>> getAllProducts() async {
    final cached = await _local.getAllProducts();

    if (cached.isNotEmpty) {
      debugPrint('CACHE HIT: getAllProducts');

      return cached
          .map((e) => ProductPayload.fromJson(e.toJson()))
          .toList();
    }

    final map = await get('/products');
    debugPrint('GET response: $map');

    final List<ProductPayload> fresh = (map as List)
    .map((json) => ProductPayload.fromJson(json))
    .toList();

    await _local.setProducts(
      fresh.map(ProductLocalStorageModel.fromProduct).toList(),
    );

    return fresh;
  }

  @override
  Future<ProductPayload> createProduct(ProductPayload product) async {
    final map = await post(
      '/products',
      jsonEncode(product.toJson()),
    );
    debugPrint('POST response: $map');

    final created = ProductPayload.fromJson(map);

    await _local.addProducts([
      ProductLocalStorageModel.fromProduct(created),
    ]);

    return created;
  }

  @override
  Future<ProductPayload> updateProduct(ProductPayload product, String id) async {
    final map = await put(
      '/products/$id',
      jsonEncode(product.toJson()),
    );
    debugPrint('PUT response: $map');

    final updated = ProductPayload.fromJson(map);

    if (updated.id != null && updated.id!.isNotEmpty) {
      await _local.addProducts([
        ProductLocalStorageModel.fromProduct(updated),
      ]);
    }
    
    return updated;
  }

  @override
  Future<void> deleteProduct(String id) async {
    await deleteContent('/products/$id');
    await _local.deleteProduct(id);
  }

  @override
  Future<ProductPageSet> searchPage(ProductSearch payload) async {
    final map = await post('/products/search',
        jsonEncode(payload.toJson())
    );
    debugPrint('GET response: $map');
    return ProductPageSet.fromJson(map);
  }
}
