import 'package:flutter/material.dart';

import '../../../ui/theme/theme.dart';
import '../../../ui/ui.dart';

class SearchRhymesBottomSheet extends StatelessWidget {
  SearchRhymesBottomSheet({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.hintColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: controller,
                      cursorColor: themeData.primaryColor,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(
                          color: themeData.hintColor.withOpacity(0.5),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => _onTapSearch(context),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: themeData.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                title: Text("word is autocomplited"),
                onTap: () {},
              ),
              separatorBuilder: (context, _) => Divider(
                height: 1,
              ),
              itemCount: 15,
            ),
          )
        ],
      ),
    );
  }

  void _onTapSearch(BuildContext context) {
    Navigator.of(context).pop(controller.text);
  }
}
