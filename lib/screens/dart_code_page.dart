import 'package:dart_code_viewer2/dart_code_viewer2.dart';
import 'package:design/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:design/code_data/codes.dart';

class DartCodePage extends StatelessWidget {
  final int indx;
  const DartCodePage({Key? key,required this.indx}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PageAppbar(title: "Dart Code"),
      body: DartCodeViewer.light(Code.Codes[indx]),
    );
  }
}
