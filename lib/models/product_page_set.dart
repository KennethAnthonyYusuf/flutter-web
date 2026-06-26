import 'package:json_annotation/json_annotation.dart';
import 'models.dart';

part 'product_page_set.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductPageSet {
 
  final List<ProductPayload>? items;

  final bool? more;

  final int? total;

  const ProductPageSet({
    this.items,
    this.more,
    this.total,
  });

  factory ProductPageSet.fromJson(Map<String, dynamic> json) =>
      _$ProductPageSetFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPageSetToJson(this);

}
