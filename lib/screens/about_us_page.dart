import 'package:design/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppbar(title: "About Us",),
        body: content());
  }

  Center content() {
    return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
              "Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen MOBİL PROGRAMLAMA dersi kapsamında 193311024 numaralı Mehmet Ali Kuyucu tarafından yapılmıştır."),
        ),
      );
  }
}
