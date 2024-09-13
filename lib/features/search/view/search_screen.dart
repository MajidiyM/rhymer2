import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer2/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer2/ui/theme/theme.dart';

import '../../../ui/ui.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    BlocProvider.of<RhymesListBloc>(context).add(
      SearchRhymes(query: "love"),
    );
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
              onTap: () {
                _showSearchBottomSheet(context, themeData);
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
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) {
                final rhymes = List.generate(4, (index) => "Рифма $index");
                return RhymeHistoryCard(
                  rhymes: rhymes,
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        BlocBuilder<RhymesListBloc, RhymesListState>(
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

  void _showSearchBottomSheet(BuildContext context, ThemeData themeData) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 105.0),
        child: SearchRhymesBottomSheet(),
      ),
    );
  }
}
