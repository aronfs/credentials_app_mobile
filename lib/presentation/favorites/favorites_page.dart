import 'package:archive_secure/l10n/app_localizations.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_event.dart';
import 'package:archive_secure/presentation/favorites/bloc/favorites_state.dart';
import 'package:archive_secure/presentation/favorites/widgets/favorite_credential_card.dart';
import 'package:archive_secure/presentation/favorites/widgets/favorites_empty_state.dart';
import 'package:archive_secure/presentation/favorites/widgets/favorites_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const FavoritesRequested());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FavoritesBloc>().add(const FavoritesNextPageRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.favoritesTitle,
                    style: tt.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.favoritesSubtitle,
                    style: tt.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: FavoritesSearchBar(
                onSearchChanged: (query) => context
                    .read<FavoritesBloc>()
                    .add(FavoritesSearchChanged(query: query)),
                onClear: () => context
                    .read<FavoritesBloc>()
                    .add(const FavoritesSearchChanged(query: '')),
              ),
            ),
            Expanded(
              child: BlocConsumer<FavoritesBloc, FavoritesState>(
                listener: (context, state) {
                  if (state is FavoritesActionFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: cs.error,
                      ),
                    );
                  }
                  if (state is FavoritesFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: cs.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is FavoritesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FavoritesFailure) {
                    return _ErrorView(
                      error: state.error,
                      onRetry: () => context
                          .read<FavoritesBloc>()
                          .add(const FavoritesRefreshed()),
                    );
                  }
                  if (state is FavoritesLoaded) {
                    if (state.items.isEmpty) {
                      return FavoritesEmptyState(
                        isSearchEmpty:
                            state.currentSearch != null && state.currentSearch!.isNotEmpty,
                        searchQuery: state.currentSearch,
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<FavoritesBloc>()
                            .add(const FavoritesRefreshed());
                        await Future.delayed(
                            const Duration(milliseconds: 500));
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 4, bottom: 90),
                        itemCount: state.items.length +
                            (state.hasNextPage ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.items.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final credential = state.items[index];
                          return FavoriteCredentialCard(
                            credential: credential,
                            onRemove: () => context
                                .read<FavoritesBloc>()
                                .add(FavoriteRemoved(
                                    credentialId: credential.id)),
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }
                  if (state is FavoritesLoadingMore) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<FavoritesBloc>()
                            .add(const FavoritesRefreshed());
                        await Future.delayed(
                            const Duration(milliseconds: 500));
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 4, bottom: 90),
                        itemCount: state.currentItems.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= state.currentItems.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          final credential = state.currentItems[index];
                          return FavoriteCredentialCard(
                            credential: credential,
                            onRemove: () => context
                                .read<FavoritesBloc>()
                                .add(FavoriteRemoved(
                                    credentialId: credential.id)),
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final loc = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_rounded, size: 64, color: cs.error),
            const SizedBox(height: 16),
            Text(
              error,
              style: tt.bodyLarge?.copyWith(color: cs.onSurface),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(loc.favoritesRetry),
            ),
          ],
        ),
      ),
    );
  }
}
