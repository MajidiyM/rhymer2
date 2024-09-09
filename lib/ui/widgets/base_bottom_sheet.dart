import "package:flutter/material.dart";

import "../theme/theme.dart";

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: themeData.canvasColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: SizedBox(
        width: double.infinity,
        child: child,
      ),
    );
  }
}
