import 'package:design/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
class SupportUs extends StatelessWidget {
  const SupportUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppbar(title: "Support US",),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Bitcoin address",style: TextStyle(fontSize: 24,height: 1.50),),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh",textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}