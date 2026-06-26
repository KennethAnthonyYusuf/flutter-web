// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearch _$ProductSearchFromJson(Map<String, dynamic> json) =>
    ProductSearch(
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      query: json['query'] as String?,
    );

Map<String, dynamic> _$ProductSearchToJson(ProductSearch instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'query': instance.query,
    };
