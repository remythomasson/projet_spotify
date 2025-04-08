import 'package:equatable/equatable.dart';
import '../../data/models/album.dart';
import '../../data/models/track.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Album> albums;
  final List<Track> tracks;

  const SearchLoaded({this.albums = const [], this.tracks = const []});

  @override
  List<Object?> get props => [albums, tracks];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
