// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumResponse _$AlbumResponseFromJson(Map<String, dynamic> json) =>
    AlbumResponse(
      loved: (json['loved'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumResponseToJson(AlbumResponse instance) =>
    <String, dynamic>{
      'loved': instance.loved,
    };
