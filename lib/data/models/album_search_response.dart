import 'package:json_annotation/json_annotation.dart';
import 'album.dart';

part 'album_search_response.g.dart';

@JsonSerializable()
class AlbumSearchResponse {
  @JsonKey(name: 'album')
  final List<Album>? albums;

  AlbumSearchResponse({this.albums});

  factory AlbumSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AlbumSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumSearchResponseToJson(this);
}
