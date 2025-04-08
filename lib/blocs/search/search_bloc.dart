import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projet_musique/data/api/music_api.dart';
import 'package:projet_musique/data/models/album.dart';
import 'package:projet_musique/data/models/track.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MusicApi api;

  SearchBloc(this.api) : super(SearchInitial()) {
    on<SearchAlbums>((event, emit) async {
      emit(SearchLoading());
      try {
        final response = await api.searchAlbums(event.query);
        emit(SearchLoaded(albums: response.albums?.cast<Album>() ?? []));
      } catch (e) {
        emit(SearchError("Erreur lors de la recherche d'albums"));
      }
    });

    on<SearchTracks>((event, emit) async {
      emit(SearchLoading());
      try {
        final response = await api.searchTracks(event.query);
        emit(SearchLoaded(tracks: response.albums?.cast<Track>() ?? []));
      } catch (e) {
        emit(SearchError("Erreur lors de la recherche de morceaux"));
      }
    });
  }
}
