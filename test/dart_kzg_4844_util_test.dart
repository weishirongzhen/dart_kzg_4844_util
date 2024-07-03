import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util_method_channel.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
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

  test('data to blob', () {
    /// json字符串{"protocol":"blob20","token":{"operation":"mint","ticker":"ETHS","amount":1000}}对应值为：
    /// 00a267636f6e74656e7478507b2270726f746f636f6c223a22626c6f62323022002c22746f6b656e223a7b226f7065726174696f6e223a226d696e74222c22740069636b6572223a2245544853222c22616d6f756e74223a313030307d7d6b63006f6e74656e7454797065706170706c69636174696f6e2f6a736f6e80
    const text =
        '{"protocol":"blob20","token":{"operation":"mint","ticker":"ETHS","amount":1000}}';

    final cborData = cborEncodeApplicationJson(text);
    final result = cborDataToESIP8Blobs(cborData);

    print(result.first.toHex());
  });
}
