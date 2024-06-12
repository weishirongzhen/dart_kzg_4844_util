import 'dart:typed_data';

import 'package:dart_kzg_4844_util/dart_kzg_4844_util.dart';

import '../api/kzg.dart';

class Blob {
  Uint8List blob = Uint8List(DartKzg4844Util.blobByteSize);

  Future<Blob> randBlob() async {
    blob = await generateRandBlob();
    return this;
  }
}
