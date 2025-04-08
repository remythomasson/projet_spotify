import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

enum SearchTab { albums, tracks }

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _controller = TextEditingController();
  SearchTab selectedTab = SearchTab.albums;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          ToggleButtons(
            isSelected: [
              selectedTab == SearchTab.albums,
              selectedTab == SearchTab.tracks,
            ],
            onPressed: (index) {
              setState(() {
                selectedTab = SearchTab.values[index];
              });
              _onSearchChanged();
            },
            borderRadius: BorderRadius.circular(10),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Albums'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Morceaux'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onChanged: (_) => _onSearchChanged(),
              decoration: const InputDecoration(
                hintText: 'Rechercher...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  final results = selectedTab == SearchTab.albums
                      ? state.albums
                      : state.tracks;

                  if (results.isEmpty) {
                    return const Center(child: Text('Aucun résultat trouvé.'));
                  }

                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final item = results[index];

                      if (item is Album) {
                        return ListTile(
                          leading: item.thumbnail != null
                              ? Image.network(item.thumbnail!, width: 56)
                              : const Icon(Icons.album),
                          title: Text(item.title),
                          subtitle: Text(item.artist),
                        );
                      } else if (item is Track) {
                        return ListTile(
                          leading: item.thumbnail != null
                              ? Image.network(item.thumbnail!, width: 56)
                              : const Icon(Icons.music_note),
                          title: Text(item.title),
                          subtitle: Text(item.artist),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else if (state is SearchError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Commencez une recherche.'));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _onSearchChanged() {
    final query = _controller.text;
    final bloc = context.read<SearchBloc>();
    if (query.length < 2) return;

    if (selectedTab == SearchTab.albums) {
      bloc.add(SearchAlbums(query));
    } else {
      bloc.add(SearchTracks(query));
    }
  }
}
