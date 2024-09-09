import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/ui.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            title: Text(
              "History",
            ),
            // bottom: PreferredSize(
            //   child: SearchButton(
            //     onTap: () {},
            //   ),
            //   preferredSize: Size.fromHeight(70),
            // ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: RhymeHistoryCard(
                      rhymes: [
                        "jdjncsjncjsn",
                        "jdnsjsnjcnsjc",
                        "jsncskjndjcsn",
                        "cskhbdjhsbjchbsc"
                      ],
                    ),
                  );
                },
                childCount: 20,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2, //1.4
              ),
            ),
          ),
        ],
      ),
    );
  }
}
