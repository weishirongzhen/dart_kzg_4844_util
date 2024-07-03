# dart_kzg_4844_util

For EIP-4844, dart impl 

## source project
[c-kzg-4844](https://github.com/ethereum/c-kzg-4844)

```dart
import 'package:convert/convert.dart';
import 'package:dart_kzg_4844_util/dart_kzg_4844_util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BlobTxSidecar? sidecar;
  KzgSetting? kzgSetting;

  @override
  void initState() {
    _test();
    super.initState();
  }

  void _test() async {
    await DartKzg4844Util.init();
    await loadSetting();
    _generateCommitmentAndProof();
  }

  Future<void> loadSetting() async {
    kzgSetting = await KzgSetting.loadFromFile('assets/trusted_setup.json');
  }

  void _generateCommitmentAndProof() async {
    final blobs = <Blob>[];
    final commitments = <KzgCommitment>[];
    final proofs = <KzgProof>[];
    blobs.add(await Blob().randBlob());
    blobs.add(await Blob().randBlob());

    /// commitments hash with Blob contain all 0
    /// 010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014
    blobs.add(Blob()); // 全0

    for (var b in blobs) {
      final commit = await Kzg4844.kzgBlobToCommitment(b, kzgSetting!);
      commitments.add(commit);
      final p = await Kzg4844.kzgComputeBlobKzgProof(b, commit, kzgSetting!);
      proofs.add(p);
    }

    sidecar = BlobTxSidecar(
      blobs: blobs,
      commitments: commitments,
      proofs: proofs,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: sidecar != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(sidecar!.blobs.length, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "commitment = ${hex.encode(sidecar!.commitments[index].commitment)}"),
                      Text(
                          "proof = ${hex.encode(sidecar!.proofs[index].proof)}"),
                      Text(
                          "hash = ${hex.encode(sidecar!.blobHashes()[index])}"),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

```

