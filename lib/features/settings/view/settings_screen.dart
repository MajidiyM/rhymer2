import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
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
    final theme = Theme.of(context);
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
              iconColor: theme.primaryColor,
              ontap: () => _confirmClearHistory(context),
            ),
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
        .setThemeBrightness(value ? Brightness.dark : Brightness.light);
  }

  void _confirmClearHistory(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          onConfirm: () => _clearHistory(context),
        ),
      );
      return;
    }
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => ConfirmationDialog(
        onConfirm: () => _clearHistory(context),
      ),
    );
  }

  void _clearHistory(BuildContext context) {
    BlocProvider.of<HistoryRhymesBloc>(context).add(ClearRhymesHistory());
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isAndroid) {
      return AlertDialog(
        backgroundColor: theme.cardColor,
        surfaceTintColor: theme.cardColor,
        content: _DialogContent(
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        actions: [
          TextButton(
            onPressed: () => _confirm(context),
            child: Text(
              "Да",
              style: TextStyle(color: theme.hintColor),
            ),
          ),
          TextButton(
            onPressed: () => _close(context),
            child: Text("Нет"),
          ),
        ],
      );
    }
    return CupertinoAlertDialog(
      content: _DialogContent(
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => _confirm(context),
          isDestructiveAction: true,
          child: Text(
            "Да",
            style: TextStyle(
              color: theme.cupertinoAlertColor,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () => _close(context),
          isDestructiveAction: true,
          child: Text(
            "Нет",
            style: TextStyle(
              color: Color(0xFF3478F7),
            ),
          ),
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _confirm(BuildContext context) {
    onConfirm.call();
    Navigator.of(context).pop();
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    super.key,
    required this.crossAxisAlignment,
  });

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Вы уверены?",
          style: theme.textTheme.headlineSmall,
        ),
        Text(
          "При согласии истрия будет удалена навсегда",
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
