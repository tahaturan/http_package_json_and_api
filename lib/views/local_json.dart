import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_package_json_and_api/model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  Future<List<ArabaModel>> arabalarJsonOku() async {
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/arabalar.json");

    var jsonArray = jsonDecode(okunanString);
    // debugPrint(okunanString);
    // debugPrint("*********************");
    // List arabaListesi = jsonObject;
    // debugPrint(arabaListesi[1]["model"][0]["model_adi"].toString());

    List<ArabaModel> tumArabalar = (jsonArray as List)
        .map((arabaMap) => ArabaModel.fromMap(arabaMap))
        .toList();
    // debugPrint(tumArabalar.length.toString());
    // debugPrint(tumArabalar[0].model[0].modelAdi);

    return tumArabalar;
  }

  String _title = "Local Json Islemleri";

  late final Future<List<ArabaModel>> _listeyiDoldur;

  @override
  void initState() {
    super.initState();
    _listeyiDoldur = arabalarJsonOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: FutureBuilder<List<ArabaModel>>(
        future: _listeyiDoldur,
        initialData: [
          ArabaModel(arabaAdi: "Ford", ulke: "TR", kurulusYil: 1930, model: [
            Model(modelAdi: "Fiesta", fiyat: 20000, benzinli: false)
          ]),
        ],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ArabaModel> arabaListesi = snapshot.data;
            return ListView.builder(
              itemCount: arabaListesi.length,
              itemBuilder: (BuildContext context, int index) {
                var araba = arabaListesi[index];
                return ListTile(
                  title: Text(araba.arabaAdi),
                  subtitle: Text(araba.ulke),
                  leading: CircleAvatar(
                    child: Text(araba.model[0].fiyat.toString()),
                  ),
                );
              },
            );
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _title = "Buton Tiklandi";
          });
        },
      ),
    );
  }
}
