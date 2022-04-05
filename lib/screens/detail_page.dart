import 'package:design/models/design_patterns_model.dart';
import 'package:design/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:design/screens/dart_code_page.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, required this.designPattern, required this.indx})
      : super(key: key);
  final DesignPatterns designPattern;
  final int indx;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppbar(
        title: designPattern.title,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                designPattern.content,
                style: const TextStyle(height: 1.5, color: Colors.black),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DartCodePage(indx: indx,)));
                },
                child: Text("Show ${designPattern.title} Code"))
          ],
        ),
      ),
    );
  }
}
