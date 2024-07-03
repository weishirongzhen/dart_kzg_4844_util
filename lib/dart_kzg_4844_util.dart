import 'package:dart_kzg_4844_util/frb_generated.dart';

export 'dart_kzg/sidecar.dart';
export 'dart_kzg/kzg_setting.dart';
export 'dart_kzg/kzg_4844.dart';
export 'dart_kzg/kzg_commitment.dart';
export 'dart_kzg/kzg_proof.dart';
export 'dart_kzg/blob.dart';
export 'esip8/esip8.dart';

/// Blob limit per transaction.
const int blobsPerTransaction = 6;

/// The number of bytes in a BLS scalar field element.
const int bytesPerFieldElement = 32;

/// The number of field elements in a blob.
const fieldElementsPerBlob = 4096;

/// The number of bytes in a blob.
const blobByteSize = bytesPerFieldElement * fieldElementsPerBlob;

/// Blob bytes limit per transaction.
const maxBytesPerTransaction = blobByteSize * blobsPerTransaction -
    // terminator byte (0x80).
    1 -
    // zero byte (0x00) appended to each field element.
    1 * fieldElementsPerBlob * blobsPerTransaction;

/// Commitment length
const commitmentByteSize = 48;

/// proof length
const proofByteSize = 48;


const blob20CallData = "data:;rule=esip6,";

class DartKzg4844Util {
  static bool _init = false;

  DartKzg4844Util._();

  static Future<void> init() async {
    try {
      if (!_init) {
        await RustLib.init();
      }
      _init = true;
    } catch (_) {
      _init = false;
    }
  }
}
