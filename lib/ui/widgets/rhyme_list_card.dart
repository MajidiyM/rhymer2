import 'package:flutter/material.dart';
import 'package:rhymer2/ui/theme/theme.dart';
import 'package:rhymer2/ui/ui.dart';

class RhymeListCard extends StatelessWidget {
  const RhymeListCard({
    super.key,
    this.isFavorite = false,
    required this.rhyme,
    this.sourceWord,
  });

  final String? sourceWord;
  final String rhyme;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (sourceWord != null) ...[
                Text(
                  sourceWord!,
                  style: themeData.textTheme.bodyLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: themeData.hintColor.withOpacity(0.4),
                  ),
                ),
              ],
              Text(
                rhyme,
                style: themeData.textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            color: isFavorite
                ? themeData.primaryColor
                : themeData.hintColor.withOpacity(0.2),
          )
        ],
      ),
    );
  }
}
