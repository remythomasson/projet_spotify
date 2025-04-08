// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumSearchResponse _$AlbumSearchResponseFromJson(Map<String, dynamic> json) =>
    AlbumSearchResponse(
      albums: (json['album'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumSearchResponseToJson(
        AlbumSearchResponse instance) =>
    <String, dynamic>{
      'album': instance.albums,
    };
