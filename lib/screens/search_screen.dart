import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';

import '../blocs/search/search_bloc.dart';
import '../blocs/search/search_event.dart';
import '../blocs/search/search_state.dart';
import '../data/api/music_api.dart';
import '../data/models/album.dart';
import '../data/models/track.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(MusicApi(Dio())),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView({super.key});

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late TabController _tabController;
  final green = const Color(0xFF1BB46B);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _controller.text;
    final bloc = context.read<SearchBloc>();
    if (query.length < 2) return;

    if (_tabController.index == 0) {
      bloc.add(SearchAlbums(query));
    } else {
      bloc.add(SearchTracks(query));
    }
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Recherche',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  SvgPicture.asset('assets/icons/Recherche_Loupe.svg', height: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Rechercher...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/Recherche_Annuler.svg', height: 20),
                      onPressed: _clearSearch,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            onTap: (_) => _onSearchChanged(),
            indicatorColor: green,
            labelColor: green,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: const [
              Tab(text: 'Albums'),
              Tab(text: 'Titres'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildResults(isAlbum: true),
                _buildResults(isAlbum: false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildResults({required bool isAlbum}) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchLoaded) {
          final results = isAlbum ? state.albums : state.tracks;

          if (results.isEmpty) {
            return const Center(child: Text('Aucun résultat trouvé.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              final title = isAlbum ? (item as Album).title : (item as Track).title;
              final artist = isAlbum ? (item as Album).artist : (item as Track).artist;
              final thumbnail = isAlbum ? (item as Album).thumbnail : (item as Track).thumbnail;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: thumbnail != null
                          ? Image.network(thumbnail, width: 56, height: 56, fit: BoxFit.cover)
                          : SvgPicture.asset(
                              isAlbum ? 'assets/icons/Placeholder_album.svg' : 'assets/icons/Placeholder_artiste.svg',
                              width: 56),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(artist, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        } else if (state is SearchError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Commencez une recherche.'));
        }
      },
    );
  }
}
