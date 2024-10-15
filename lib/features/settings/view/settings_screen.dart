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
              onTap: () => _confirmClearHistory(context),
            ),
          ),
          SliverToBoxAdapter(
            child: SettingsActionCard(
              title: 'Поддержка',
              iconData: Icons.message_rounded,
              iconColor: themeData.hintColor.withOpacity(0.3),
              onTap: () {
                _openSupport(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openSupport(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => SupportBottomSheet(),
      );
      return;
    }
    showCupertinoModalPopup(
      context: context,
      builder: (context) => SupportBottomSheet(),
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

class SupportBottomSheet extends StatelessWidget {
  const SupportBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isAndroid) {
      return Padding(
        padding: const EdgeInsets.all(24.0).copyWith(top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: () => _close(context),
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                icon: Icon(Icons.telegram),
                label: Text("Написать в Telegram"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                icon: Icon(Icons.email),
                label: Text("Отправить Email"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      );
    }
    return CupertinoActionSheet(
      title: Text("Поддержка"),
      message: Text("Ответим вам быстро!"),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          child: Text(
            "Написать в Telegram",
            style: TextStyle(
              color: theme.cupertinoActionColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Отправить Email",
            style: TextStyle(
              color: theme.cupertinoActionColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void _close(BuildContext context) {
    Navigator.of(context).pop();
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
              color: theme.cupertinoActionColor,
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
