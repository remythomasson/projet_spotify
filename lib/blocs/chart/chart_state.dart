import 'package:equatable/equatable.dart';
import '../../data/models/album.dart';
import '../../data/models/track.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

class ChartInitial extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final List<Album> topAlbums;
  final List<Track> topTracks;

  const ChartLoaded({required this.topAlbums, required this.topTracks});

  @override
  List<Object> get props => [topAlbums, topTracks];
}

class ChartError extends ChartState {
  final String message;

  const ChartError(this.message);

  @override
  List<Object> get props => [message];
}
