import 'dart:typed_data';

import 'package:dart_kzg_4844_util/dart_kzg_4844_util.dart';

class KzgProof {

  Uint8List proof = Uint8List(proofByteSize);
  KzgProof(Uint8List p) {
    proof = p;
  }

}