import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchAlbums extends SearchEvent {
  final String query;

  const SearchAlbums(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchTracks extends SearchEvent {
  final String query;

  const SearchTracks(this.query);

  @override
  List<Object?> get props => [query];
}
