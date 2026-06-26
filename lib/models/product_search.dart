import 'package:json_annotation/json_annotation.dart';

part 'product_search.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductSearch {
 
  final int? pageNumber;

  final int? pageSize;

  final String? query;

  const ProductSearch({
    this.pageNumber,
    this.pageSize,
    this.query,
  });

  factory ProductSearch.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchToJson(this);

}
