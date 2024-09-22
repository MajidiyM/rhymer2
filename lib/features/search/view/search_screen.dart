import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer2/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer2/ui/theme/theme.dart';

import '../../../ui/ui.dart';
import '../../history/bloc/history_rhymes_bloc.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          surfaceTintColor: Colors.transparent,
          title: Text("Rhymer"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: SearchButton(
              controller: _searchController,
              onTap: () {
                _showSearchBottomSheet(context);
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<HistoryRhymesBloc, HistoryRhymesState>(
            builder: (context, state) {
              if (state is! HistoryRhymesLoaded) return const SizedBox();
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.rhymes.length,
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final rhymes = state.rhymes[index];
                    return RhymeHistoryCard(
                      word: rhymes.word,
                      rhymes: rhymes.words,
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocConsumer<RhymesListBloc, RhymesListState>(
          listener: _handleRhymesListState,
          builder: (context, state) {
            if (state is RhymesListLoaded) {
              final rhymes = state.rhymes;
              return SliverList.builder(
                itemCount: rhymes.length,
                itemBuilder: (context, index) => RhymeListCard(
                  rhyme: rhymes[index],
                ),
              );
            }
            if (state is RhymesListInitial) {
              return SliverFillRemaining(
                child: RhymesListInitialBanner(),
              );
            }
            return SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(
                  color: themeData.primaryColor,
                ),
              ),
            );
          },
        )
      ],
    );
  }

  void _handleRhymesListState(BuildContext context, RhymesListState state) {
    if (state is RhymesListLoaded) {
      BlocProvider.of<HistoryRhymesBloc>(context).add(LoadHistoryRhymes());
    }
  }

  Future<void> _showSearchBottomSheet(BuildContext context) async {
    final bloc = BlocProvider.of<RhymesListBloc>(context);
    final query = await showModalBottomSheet<String>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 105.0),
        child: SearchRhymesBottomSheet(
          controller: _searchController,
        ),
      ),
    );
    if (query != null) {
      bloc.add(SearchRhymes(query: query));
    }
  }
}
