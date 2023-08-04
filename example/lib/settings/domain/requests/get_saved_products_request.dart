import 'package:json_annotation/json_annotation.dart';
part 'get_saved_products_request.g.dart';
///[GetSavedProductsRequest]
///[Implementation]
@JsonSerializable()
class GetSavedProductsRequest {
final int page;
final int limit;
const GetSavedProductsRequest({
required this.page,
required this.limit,
});

factory GetSavedProductsRequest.fromJson(Map<String, dynamic> json) => _$GetSavedProductsRequestFromJson(json);
Map<String, dynamic> toJson() => _$GetSavedProductsRequestToJson(this);
}

