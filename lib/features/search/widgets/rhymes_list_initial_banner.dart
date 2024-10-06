import 'package:flutter/material.dart';

class RhymesListInitialBanner extends StatelessWidget {
  const RhymesListInitialBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Начни искать",
            style: theme.textTheme.headlineLarge,
          ),
          Text(
            "Введите слово в строку поиска, \nчтобы найти рифмы",
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
