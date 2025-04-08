import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();

  @override
  List<Object> get props => [];
}

class LoadTopAlbums extends ChartEvent {}

class LoadTopTracks extends ChartEvent {}
