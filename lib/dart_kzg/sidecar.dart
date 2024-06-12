import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dart_kzg_4844_util/dart_kzg/blob.dart';
import 'package:dart_kzg_4844_util/dart_kzg/kzg_commitment.dart';
import 'package:dart_kzg_4844_util/dart_kzg/kzg_proof.dart';

/// all 0 commitment hash output
/// 010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014

class BlobTxSidecar {
  final List<Blob> blobs;
  final List<KzgCommitment> commitments;
  final List<KzgProof> proofs;

  BlobTxSidecar({
    required this.blobs,
    required this.commitments,
    required this.proofs,
  });

  ///  https://github.com/colinlyguo/EIP-4844-dev-usage.git
  ///  crypto/kzg4844/kzg4844.go
  ///  func CalcBlobHashV1(hasher hash.Hash, commit *Commitment) (vh [32]byte) {
  /// 	if hasher.Size() != 32 {
  /// 		panic("wrong hash size")
  /// 	}
  /// 	hasher.Reset()
  /// 	hasher.Write(commit[:])
  /// 	hasher.Sum(vh[:0])
  /// 	vh[0] = 0x01 // version
  /// 	return vh
  /// }
  List<Uint8List> blobHashes() {
    List<Uint8List> list = [];
    for (var c in commitments) {
      var hasher = sha256.convert(c.commitment);
      final bytes = hasher.bytes;
      bytes[0] = 0x01; // version
      list.add(Uint8List.fromList(bytes));
    }

    return list;
  }
}
