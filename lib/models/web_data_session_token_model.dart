import 'package:json_annotation/json_annotation.dart';

part 'web_data_session_token_model.g.dart';

@JsonSerializable()
class WebDataSessionTokenModel {
  @JsonKey(name: 'data_session_id')
  final String dataSessionId;
  final String token;

  const WebDataSessionTokenModel({
    required this.dataSessionId,
    required this.token,
  });

  factory WebDataSessionTokenModel.fromJson(Map<String, dynamic> json) =>
      _$WebDataSessionTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$WebDataSessionTokenModelToJson(this);
}

@JsonSerializable()
class WebDataSessionTokenRequestModel {
  @JsonKey(name: 'token_key')
  final String tokenKey;

  const WebDataSessionTokenRequestModel({
    required this.tokenKey,
  });

  factory WebDataSessionTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$WebDataSessionTokenRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WebDataSessionTokenRequestModelToJson(this);
}

@JsonSerializable()
class WebDataSessionPutRequestModel {
  @JsonKey(name: 'session_id')
  final String sessionId;
  @JsonKey(name: 'data')
  final String data;

  const WebDataSessionPutRequestModel({
    required this.sessionId,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$WebDataSessionPutRequestModelToJson(this);
}
