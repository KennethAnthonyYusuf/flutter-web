// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_page_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPageSet _$ProductPageSetFromJson(Map<String, dynamic> json) =>
    ProductPageSet(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductPayload.fromJson(e as Map<String, dynamic>))
          .toList(),
      more: json['more'] as bool?,
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductPageSetToJson(ProductPageSet instance) =>
    <String, dynamic>{
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'more': instance.more,
      'total': instance.total,
    };
