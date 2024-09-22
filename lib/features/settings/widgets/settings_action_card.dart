import 'package:flutter/material.dart';

import '../../../ui/theme/theme.dart';
import '../../../ui/ui.dart';

class SettingsActionCard extends StatelessWidget {
  const SettingsActionCard(
      {super.key,
      required this.title,
      this.ontap,
      required this.iconData,
      this.iconColor});

  final String title;
  final IconData iconData;
  final Color? iconColor;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
        child: BaseContainer(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: themeData.textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
