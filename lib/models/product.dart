import 'package:json_annotation/json_annotation.dart';

import '../../models/models.dart';
part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductPayload {
  final String? id;

  final String? productType;

  final String? name;

  final bool? newProduct;

  final String? description;

  final double? price;

  final bool? stock;

  final int? warrantyInMonths;

  final DateTime? createdDate;

  final DateTime? updatedDate;

  const ProductPayload({
    this.id,
    this.productType,
    this.name,
    this.newProduct,
    this.description,
    this.price,
    this.stock,
    this.warrantyInMonths,
    this.createdDate,
    this.updatedDate,
  });

  factory ProductPayload.fromJson(Map<String, dynamic> json) =>
      _$ProductPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPayloadToJson(this);

  factory ProductPayload.fromLocal(ProductLocalStorageModel m) {
    return ProductPayload(
      id: m.id,
      productType: m.productType,
      name: m.name,
      newProduct: m.newProduct,
      description: m.description,
      price: m.price,
      stock: m.stock,
      warrantyInMonths: m.warrantyInMonths,
      createdDate: m.createdDate,
      updatedDate: m.updatedDate,
    );
  }


}
