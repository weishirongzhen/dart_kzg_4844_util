// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.36.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<KSettings> loadKzgSetting(
        {required List<Uint8List> g1Bytes,
        required List<Uint8List> g2Bytes,
        dynamic hint}) =>
    RustLib.instance.api.crateApiKzgLoadKzgSetting(
        g1Bytes: g1Bytes, g2Bytes: g2Bytes, hint: hint);

Future<Uint8List> generateRandBlob({dynamic hint}) =>
    RustLib.instance.api.crateApiKzgGenerateRandBlob(hint: hint);

Future<String> blobToCommitment(
        {required List<int> blob,
        required KSettings kzgSettings,
        dynamic hint}) =>
    RustLib.instance.api.crateApiKzgBlobToCommitment(
        blob: blob, kzgSettings: kzgSettings, hint: hint);

Future<String> computeBlobKzgProof(
        {required List<int> blob,
        required List<int> commitment,
        required KSettings kzgSettings,
        dynamic hint}) =>
    RustLib.instance.api.crateApiKzgComputeBlobKzgProof(
        blob: blob,
        commitment: commitment,
        kzgSettings: kzgSettings,
        hint: hint);

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<KSettings>>
@sealed
class KSettings extends RustOpaque {
  KSettings.dcoDecode(List<dynamic> wire) : super.dcoDecode(wire, _kStaticData);

  KSettings.sseDecode(BigInt ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_KSettings,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_KSettings,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_KSettingsPtr,
  );
}
