import 'package:dart_kzg_4844_util/frb_generated.dart';

export 'dart_kzg/sidecar.dart';
export 'dart_kzg/kzg_setting.dart';
export 'dart_kzg/kzg_4844.dart';
export 'dart_kzg/kzg_commitment.dart';
export 'dart_kzg/kzg_proof.dart';
export 'dart_kzg/blob.dart';



class DartKzg4844Util {
  static bool _init = false;

  static const blobByteSize = 131072; //byte
  static const commitmentByteSize = 48; //byte
  static const proofByteSize = 48; //byte

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
