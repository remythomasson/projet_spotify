import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  @JsonKey(name: 'idTrack')
  final String id;
  @JsonKey(name: 'strTrack')
  final String title;
  @JsonKey(name: 'strArtist')
  final String artist;
  @JsonKey(name: 'strTrackThumb')
  final String? thumbnail;

  Track({
    required this.id,
    required this.title,
    required this.artist,
    this.thumbnail,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
