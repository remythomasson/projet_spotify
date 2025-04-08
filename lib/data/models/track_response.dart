import 'package:json_annotation/json_annotation.dart';
import 'track.dart';

part 'track_response.g.dart';

@JsonSerializable()
class TrackResponse {
  final List<Track>? loved;

  TrackResponse({this.loved});

  factory TrackResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrackResponseToJson(this);
}
