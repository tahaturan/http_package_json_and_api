import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_package_json_and_api/model/araba_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  @override
  Widget build(BuildContext context) {
    arabalarJsonOku();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Json Islemleri'),
      ),
      body: Container(),
    );
  }

  arabalarJsonOku() async {
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
    debugPrint(tumArabalar.length.toString());
    debugPrint(tumArabalar[0].model[0].modelAdi);
  }
}
