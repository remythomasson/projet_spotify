import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/chart_screen.dart';
import 'screens/search_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'blocs/chart/chart_bloc.dart';
import 'blocs/chart/chart_event.dart';
import 'data/api/music_api.dart';
import 'package:dio/dio.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/charts',
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: '/charts',
          builder: (context, state) => BlocProvider(
            create: (_) => ChartBloc(MusicApi(Dio()))..add(LoadTopAlbums()),
            child: const ChartScreen(),
          ),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
      ],
    ),
  ],
);
