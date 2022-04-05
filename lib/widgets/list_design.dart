import 'dart:convert';
import 'package:design/models/design_patterns_model.dart';
import 'package:design/screens/detail_page.dart';
import 'package:flutter/material.dart';
class DesignPatternsList extends StatefulWidget {
  const DesignPatternsList({Key? key}) : super(key: key);

  @override
  State<DesignPatternsList> createState() => _DesignPatternsListState();
}

class _DesignPatternsListState extends State<DesignPatternsList> {
  // ignore: non_constant_identifier_names
  Future<List<DesignPatterns>> DesignPatternsJsonOku() async {
    try {
      String okunanString = await DefaultAssetBundle.of(context)
          .loadString('assets/design_pattern.json');

      var jsonArray = jsonDecode(okunanString);

      List<DesignPatterns> tumDesignPatternslar = (jsonArray as List)
          // ignore: non_constant_identifier_names
          .map((DesignPatternsMap) => DesignPatterns.fromMap(DesignPatternsMap))
          .toList();

      debugPrint(tumDesignPatternslar.length.toString());

      return tumDesignPatternslar;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
    
  }


  late final Future<List<DesignPatterns>> _listeyiDoldur;

  @override
  void initState() {
    super.initState();
    _listeyiDoldur = DesignPatternsJsonOku();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DesignPatterns>>(
      future: _listeyiDoldur,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DesignPatterns> designPatternsListesi = snapshot.data!;

          return ListView.builder(
              itemCount: designPatternsListesi.length,
              itemBuilder: (context, index) {
                DesignPatterns oankiDesignPatterns =designPatternsListesi[index];
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(designPattern: oankiDesignPatterns,indx: index,)));
                  },
                  title: Text(oankiDesignPatterns.title),
                );
              });
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
