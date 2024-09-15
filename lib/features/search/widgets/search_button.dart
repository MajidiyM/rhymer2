import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.onTap,
    required this.controller,
  });

  final TextEditingController controller;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.hintColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded),
            SizedBox(
              width: 12,
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, _) {
                return Text(
                  controller.text.isEmpty ? "Поиск рифм" : controller.text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: theme.hintColor.withOpacity(0.4),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
