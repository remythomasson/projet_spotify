// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackResponse _$TrackResponseFromJson(Map<String, dynamic> json) =>
    TrackResponse(
      loved: (json['loved'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackResponseToJson(TrackResponse instance) =>
    <String, dynamic>{
      'loved': instance.loved,
    };
