import 'package:json_annotation/json_annotation.dart';
import 'album.dart';

part 'album_response.g.dart';

@JsonSerializable()
class AlbumResponse {
  final List<Album>? loved;

  AlbumResponse({this.loved});

  factory AlbumResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumResponseToJson(this);
}
