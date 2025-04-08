// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['idAlbum'] as String,
      title: json['strAlbum'] as String,
      artist: json['strArtist'] as String,
      thumbnail: json['strAlbumThumb'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'idAlbum': instance.id,
      'strAlbum': instance.title,
      'strArtist': instance.artist,
      'strAlbumThumb': instance.thumbnail,
    };
