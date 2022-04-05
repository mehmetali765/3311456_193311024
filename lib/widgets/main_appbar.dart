import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Design Patterns"),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
