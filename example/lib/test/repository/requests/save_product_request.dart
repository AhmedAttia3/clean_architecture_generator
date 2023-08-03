import 'package:json_annotation/json_annotation.dart';
part 'save_product_request.g.dart';
///[SaveProductRequest]
///[Implementation]
@JsonSerializable()
class SaveProductRequest {
final String productId;
final String type;
const SaveProductRequest({
required this.productId,
required this.type,
});

factory SaveProductRequest.fromJson(Map<String, dynamic> json) => _$SaveProductRequestFromJson(json);
Map<String, dynamic> toJson() => _$SaveProductRequestToJson(this);
}

