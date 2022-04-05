import 'package:design/widgets/list_design.dart';
import 'package:design/widgets/main_appbar.dart';
import 'package:design/widgets/sidebar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String name;
  HomePage({Key? key, required this.name}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<HomePage> createState() => _HomePageState(name);
}

class _HomePageState extends State<HomePage> {
  String name;
  _HomePageState(this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      drawer: Sidebar(name: name),
      body: const DesignPatternsList(),
    );
  }
}
