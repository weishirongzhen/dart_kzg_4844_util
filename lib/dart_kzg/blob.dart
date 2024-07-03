import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util.dart';

import '../api/kzg.dart';

class Blob {
  final List<int> blob;

  Blob(this.blob);

  /// fixed length
  static Blob zeroBlob() {
    return Blob(Uint8List(blobByteSize));
  }

  /// dynamic length, need to handle by yourself
  static Blob emptyBlob() {
    return Blob([]);
  }

  /// fixed length
  static Future<Blob> randBlob() async {
    final data = await generateRandBlob();
    return Blob(data);
  }

  void pushByte(int byte) {
    blob.add(byte);
  }

  void pushBytes(Uint8List bytes) {
    blob.addAll(bytes);
  }

  String toHex() => hex.encode(blob);

  Uint8List hexToBytes(String hexValue) =>
      Uint8List.fromList(hex.decode(hexValue));
}
