

import 'package:design/screens/home_page.dart';
import 'package:flutter/material.dart';

class BeginnerPage extends StatefulWidget {
  const BeginnerPage({Key? key}) : super(key: key);

  @override
  State<BeginnerPage> createState() => _BeginnerPageState();
}

class _BeginnerPageState extends State<BeginnerPage> {
  final _formKey = GlobalKey<FormState>();    
  String name="";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            height: 200,
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "boş geçme lan";
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(hintText: "İsmini öğrenebilir miyim?",border: OutlineInputBorder()),
                  onChanged: (text) {
                    name = text;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage(name:name)));
                      }
                     
                    },
                    child: const Text("tamamdır"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
