import 'dart:typed_data';

import 'package:dart_kzg_4844_util/dart_kzg_4844_util.dart';

class KzgCommitment {
  Uint8List commitment = Uint8List(commitmentByteSize);
  KzgCommitment(Uint8List c) {
    commitment = c;
  }
}
