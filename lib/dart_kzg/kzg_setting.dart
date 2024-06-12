import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter/services.dart';

import '../api/kzg.dart';

class KzgSetting {
  KzgSetting._();

  static late List<Uint8List> _g1BytesList;
  static late List<Uint8List> _g2BytesList;

  static Future<KzgSetting> loadFromFile(String trustedSetupPath) async {
    final trustedSetup = await rootBundle.loadString(trustedSetupPath);
    final map = jsonDecode(trustedSetup);
    _g1BytesList = List<Uint8List>.from(map['g1_lagrange']
        .map((e) => Uint8List.fromList(hex.decode(e.toString()))));
    _g2BytesList = List<Uint8List>.from(map['g2_monomial']
        .map((e) => Uint8List.fromList(hex.decode(e.toString()))));
    return KzgSetting._();
  }

  static Future<KzgSetting> loadFromBytes(
      List<Uint8List> g1Lagrange, List<Uint8List> g2Monomial) async {
    _g1BytesList = g1Lagrange;
    _g2BytesList = g2Monomial;
    return KzgSetting._();
  }

  Future<KSettings> get setting => loadKzgSetting(g1Bytes: _g1BytesList, g2Bytes: _g2BytesList);


  void destroy() {
    _g1BytesList.clear();
    _g2BytesList.clear();
  }
}
