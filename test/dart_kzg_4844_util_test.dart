import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_kzg_4844_util/dart_kzg/kzg_commitment.dart';
import 'package:dart_kzg_4844_util/dart_kzg/sidecar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util_platform_interface.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDartKzg4844UtilPlatform
    with MockPlatformInterfaceMixin
    implements DartKzg4844UtilPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DartKzg4844UtilPlatform initialPlatform =
      DartKzg4844UtilPlatform.instance;

  test('$MethodChannelDartKzg4844Util is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDartKzg4844Util>());
  });

  test("aa", () {
    final c = Uint8List.fromList(hex.decode(
        'c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'));
    final aa =
        BlobTxSidecar(blobs: [], commitments: [KzgCommitment(c)], proofs: [])
            .blobHashes();
    final result = hex.encode(aa.first as List<int>);
    print(result);
    expect('010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014',
        result);
  });
}
