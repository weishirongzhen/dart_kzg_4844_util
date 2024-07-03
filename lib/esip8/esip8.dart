import 'dart:typed_data';

import 'package:cbor/cbor.dart';

import '../dart_kzg_4844_util.dart';

class EmptyBlobError implements Exception {}

class BlobSizeTooLargeError implements Exception {
  final int maxSize;
  final int size;

  BlobSizeTooLargeError({required this.maxSize, required this.size});
}

/// [appendToBlobSize] 如果为true将会把，blob的长度追加到单个 blob128KB的大小
/// 比如：
/// 如果输入的byte长度计算后没有超过 128KB， 则用0往后填充到128K
/// 如果byte长度计算后为 200K， 则说明第二个 blob不足128K，则将第二个blob的长度用0往后填充到128K，
/// 确保每个blob的大小都为 128KB
List<Blob> cborDataToESIP8Blobs(List<int> bytes, {bool appendToBlobSize = true}) {
  Uint8List data = Uint8List.fromList(bytes);

  int size_ = data.length;
  if (size_ == 0) throw EmptyBlobError();
  if (size_ > maxBytesPerTransaction) {
    throw BlobSizeTooLargeError(maxSize: maxBytesPerTransaction, size: size_);
  }

  List<Blob> blobs = [];

  bool active = true;
  int position = 0;
  while (active) {
    Blob blob = Blob.emptyBlob();

    int size = 0;
    while (size < fieldElementsPerBlob) {
      int end = position + (bytesPerFieldElement - 1);
      if (end > data.length) {
        end = data.length;
      }
      Uint8List bytes = data.sublist(position, end);
      // Push a zero byte so the field element doesn't overflow the BLS modulus.
      blob.pushByte(0x00);

      // Push the current segment of data bytes.
      blob.pushBytes(bytes);

      // If we detect that the current segment of data bytes is less than 31 bytes,
      // we can stop processing and push a terminator byte to indicate the end of the blob.
      if (bytes.length < 31) {
        blob.pushByte(0x80);
        active = false;
        break;
      }

      size++;
      position += 31;
    }

    if (appendToBlobSize) {
      while (blob.blob.length < blobByteSize) {
        blob.pushByte(0x00);
      }
    }
    blobs.add(blob);
  }

  return blobs;
}

List<int> cborEncodeApplicationJson(String content) {
  return cbor.encode(CborValue({
    'content': content,
    'contentType': 'application/json',
  }));
}
//
// List<int> cborEncodeTextPlain(String content) {
//   return cbor.encode(CborValue({
//     'content': content,
//     'contentType': 'text/plain',
//   }));
// }
//
// List<int> cborEncodeAnyObject(List<int> bytes, String contentType) {
//   return cbor.encode(CborValue({
//     'content': CborBytes(bytes),
//     'contentType': contentType,
//   }));
// }
