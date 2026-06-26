import '../../models/models.dart';

class ProductLocalStorageModel {
  final String id;
  final String? productType;
  final String? name;
  final bool? newProduct;
  final String? description;
  final double? price;
  final bool? stock;
  final int? warrantyInMonths;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  const ProductLocalStorageModel({
    required this.id,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productType': productType,
      'name': name,
      'newProduct': newProduct,
      'description': description,
      'price': price,
      'stock': stock,
      'warrantyInMonths': warrantyInMonths,
      'createdDate': createdDate?.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
    };
  }

  factory ProductLocalStorageModel.fromJson(Map<String, dynamic> json) {
    return ProductLocalStorageModel(
      id: json['id'] as String,
      productType: json['productType'] as String?,
      name: json['name'] as String?,
      newProduct: json['newProduct'] as bool?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stock: json['stock'] as bool?,
      warrantyInMonths: json['warrantyInMonths'] as int?,
      createdDate: (json['createdDate'] as String?) != null
          ? DateTime.tryParse(json['createdDate'] as String)
          : null,
      updatedDate: (json['updatedDate'] as String?) != null
          ? DateTime.tryParse(json['updatedDate'] as String)
          : null,
    );
  }

  factory ProductLocalStorageModel.fromProduct(ProductPayload p) {
    return ProductLocalStorageModel(
      id: p.id ?? '',
      productType: p.productType,
      name: p.name,
      newProduct: p.newProduct,
      description: p.description,
      price: p.price,
      stock: p.stock,
      warrantyInMonths: p.warrantyInMonths,
      createdDate: p.createdDate,
      updatedDate: p.updatedDate,
    );
  }

}
