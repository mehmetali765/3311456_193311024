import 'package:flutter/material.dart';
class UnKnown extends StatelessWidget {
  const UnKnown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( "404"),
        centerTitle: true,
      ),
      body: const Center(
      child: Text("OOPS didn't find page"),
      ),
    );
  }
}