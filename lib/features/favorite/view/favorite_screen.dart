import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/ui.dart';
import '../../search/widgets/widgets.dart';

@RoutePage()
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            surfaceTintColor: Colors.transparent,
            title: Text("Favorite"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: SearchButton(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) => RhymeListCard(isFavorite: true),
          )
        ],
      ),
    );
  }
}
