import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/album_response.dart';
import '../models/track_response.dart';
import '../models/album_search_response.dart';

part 'music_api.g.dart';

@RestApi(baseUrl: "https://theaudiodb.com/api/v1/json/523532/")
abstract class MusicApi {
  factory MusicApi(Dio dio, {String baseUrl}) = _MusicApi;

  @GET("mostloved.php?format=album")
  Future<AlbumResponse> getTopAlbums();

  @GET("mostloved.php?format=track")
  Future<TrackResponse> getTopTracks();

  @GET("searchalbum.php")
  Future<AlbumSearchResponse> searchAlbums(@Query("a") String albumName);

  @GET("searchtrack.php")
  Future<AlbumSearchResponse> searchTracks(@Query("t") String trackName);
}
