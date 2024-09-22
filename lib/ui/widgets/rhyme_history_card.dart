import 'package:flutter/material.dart';
import 'package:rhymer2/ui/theme/theme.dart';
import 'package:rhymer2/ui/ui.dart';

class RhymeHistoryCard extends StatelessWidget {
  const RhymeHistoryCard({super.key, required this.rhymes, required this.word});

  final List<String> rhymes;
  final String word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseContainer(
      width: 200,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Flexible(
            child: Text(
              rhymes.asMap().entries.map((e) {
                final sb = StringBuffer();
                sb.write(e.value);
                if (e.key != rhymes.length - 1) {
                  sb.write(", ");
                }
                return sb.toString();
              }).join(),
              overflow: TextOverflow.ellipsis,
              style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: themeData.hintColor.withOpacity(0.4)),
              maxLines: 4,
            ),
          ),
          // Wrap(
          //   children: rhymes
          //       .map((e) => Padding(
          //             padding: EdgeInsets.only(right: 6),
          //             child: Text(e),
          //           ))
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
