import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhymer2/bloc/theme/theme_cubit.dart';
import 'package:rhymer2/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer2/ui/theme/theme.dart';

import '../widgets/widgets.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            title: Text(
              "Settings",
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: "Темная тема",
              value: isDarkTheme,
              onChanged: (value) => _setThemeBrightness(context, value),
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: "Уведомление",
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsToggleCard(
              title: "Разрешить аналитику",
              value: true,
              onChanged: (value) {},
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsActionCard(
                title: 'Очистить историю',
                iconData: Icons.delete,
                iconColor: themeData.primaryColor,
                ontap: () {
                  print("pressed");
                  _clearHistory(context);
                }),
          ),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Поддержка',
              iconData: Icons.message_rounded,
              iconColor: themeData.hintColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }

  void _setThemeBrightness(BuildContext context, bool value) {
    context
        .read<ThemeCubit>()
        .setThemeBrightness(value ? Brightness.dark : Brightness.dark);
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}
