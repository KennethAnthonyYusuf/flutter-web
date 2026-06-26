// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPayload _$ProductPayloadFromJson(Map<String, dynamic> json) =>
    ProductPayload(
      id: json['id'] as String?,
      productType: json['productType'] as String?,
      name: json['name'] as String?,
      newProduct: json['newProduct'] as bool?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stock: json['stock'] as bool?,
      warrantyInMonths: (json['warrantyInMonths'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
    );

Map<String, dynamic> _$ProductPayloadToJson(ProductPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productType': instance.productType,
      'name': instance.name,
      'newProduct': instance.newProduct,
      'description': instance.description,
      'price': instance.price,
      'stock': instance.stock,
      'warrantyInMonths': instance.warrantyInMonths,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updatedDate': instance.updatedDate?.toIso8601String(),
    };
