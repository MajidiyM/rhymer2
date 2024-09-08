import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/ui.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
            child: SearchButton(),
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
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) => RhymeListCard(),
        ),
      ],
    );
  }
}
