import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/chart/chart_bloc.dart';
import '../blocs/chart/chart_event.dart';
import '../blocs/chart/chart_state.dart';
import '../data/models/album.dart';
import '../data/models/track.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool showTracks = true;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<ChartBloc>();
    bloc
      ..add(LoadTopAlbums())
      ..add(LoadTopTracks());
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF1BB46B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Classements',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.11,
                  fontFamily: 'SF Pro Display',
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => showTracks = true),
                        child: Column(
                          children: [
                            Text(
                              'Titres',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: showTracks ? green : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 2,
                              color: showTracks ? green : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => showTracks = false),
                        child: Column(
                          children: [
                            Text(
                              'Albums',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: !showTracks ? green : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 2,
                              color: !showTracks ? green : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<ChartBloc, ChartState>(
                  builder: (context, state) {
                    if (state is ChartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ChartLoaded) {
                      final items = showTracks ? state.topTracks : state.topAlbums;
                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final isTrack = showTracks;

                          final title = isTrack ? (items[index] as Track).title : (items[index] as Album).title;
                          final subtitle = isTrack ? (items[index] as Track).artist : (items[index] as Album).artist;
                          final thumbnail = isTrack ? (items[index] as Track).thumbnail : (items[index] as Album).thumbnail;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${index + 1}', style: const TextStyle(fontSize: 18)),
                              const SizedBox(width: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: thumbnail != null
                                    ? Image.network(thumbnail, width: 56, height: 56, fit: BoxFit.cover)
                                    : SvgPicture.asset('assets/icons/Placeholder_album.svg', width: 56),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      subtitle,
                                      style: TextStyle(color: Colors.grey[600]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("Erreur lors du chargement"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
