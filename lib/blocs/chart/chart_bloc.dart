import 'package:flutter_bloc/flutter_bloc.dart';
import 'chart_event.dart';
import 'chart_state.dart';
import '../../data/api/music_api.dart';
import '../../data/models/album.dart';
import '../../data/models/track.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  final MusicApi musicApi;

  ChartBloc(this.musicApi) : super(ChartLoading()) {
    on<LoadTopAlbums>(_onLoadTopAlbums);
    on<LoadTopTracks>(_onLoadTopTracks);
  }

  List<Album> albums = [];
  List<Track> tracks = [];

  void _onLoadTopAlbums(LoadTopAlbums event, Emitter<ChartState> emit) async {
    try {
      emit(ChartLoading());
      final response = await musicApi.getTopAlbums();
      albums = (response.loved ?? []).cast<Album>();
      if (state is ChartLoaded) {
        emit(ChartLoaded(topAlbums: albums, topTracks: (state as ChartLoaded).topTracks));
      } else {
        emit(ChartLoaded(topAlbums: albums, topTracks: []));
      }
    } catch (e) {
      emit(ChartError('Erreur lors du chargement des albums'));
    }
  }

  void _onLoadTopTracks(LoadTopTracks event, Emitter<ChartState> emit) async {
    try {
      emit(ChartLoading());
      final response = await musicApi.getTopTracks();
      tracks = (response.loved ?? []).cast<Track>();
      if (state is ChartLoaded) {
        emit(ChartLoaded(topAlbums: (state as ChartLoaded).topAlbums, topTracks: tracks));
      } else {
        emit(ChartLoaded(topAlbums: [], topTracks: tracks));
      }
    } catch (e) {
      emit(ChartError('Erreur lors du chargement des titres'));
    }
  }
}
