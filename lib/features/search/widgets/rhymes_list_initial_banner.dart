import 'package:flutter/material.dart';

import '../../../ui/theme/theme.dart';

class RhymesListInitialBanner extends StatelessWidget {
  const RhymesListInitialBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Начни искать",
            style: themeData.textTheme.headlineLarge,
          ),
          Text(
            "Введите слово в строку поиска, \nчтобы найти рифмы",
            style: themeData.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
