import 'dart:typed_data';

import 'package:convert/convert.dart';

import '../api/kzg.dart';
import 'blob.dart';
import 'kzg_commitment.dart';
import 'kzg_proof.dart';
import 'kzg_setting.dart';

class Kzg4844 {
  static Future<KzgCommitment> kzgBlobToCommitment(
    Blob blob,
    KzgSetting kzgSetting,
  ) async {
    final setting = await kzgSetting.setting;
    final c = await blobToCommitment(blob: blob.blob, kzgSettings: setting);

    return KzgCommitment(Uint8List.fromList(hex.decode(c)));
  }

  static Future<KzgProof> kzgComputeBlobKzgProof(
    Blob blob,
    KzgCommitment kzgCommitment,
    KzgSetting kzgSetting,
  ) async {
    final setting = await kzgSetting.setting;
    final p = await computeBlobKzgProof(
      blob: blob.blob,
      kzgSettings: setting,
      commitment: kzgCommitment.commitment,
    );

    return KzgProof(Uint8List.fromList(hex.decode(p)));
  }
}
