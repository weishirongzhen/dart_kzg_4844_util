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
  BlobTxSidecar? blob20Sidecar;
  KzgSetting? kzgSetting;

  @override
  void initState() {
    _kzgTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              if (sidecar != null) sidecarView(),
              if (blob20Sidecar != null) blob20SidecarView(),
            ],
          )),
    );
  }

  void _kzgTest() async {
    await DartKzg4844Util.init();
    await loadSetting();
    _generateCommitmentAndProof();
    _blob20CommitmentAndProof();
  }

  Future<void> loadSetting() async {
    kzgSetting = await KzgSetting.loadFromFile('assets/trusted_setup.json');
  }

  Widget sidecarView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(sidecar!.blobs.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "commitment = ${hex.encode(sidecar!.commitments[index].commitment)}"),
            Text("proof = ${hex.encode(sidecar!.proofs[index].proof)}"),
            Text("hash = ${hex.encode(sidecar!.blobHashes()[index])}"),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }

  Widget blob20SidecarView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(blob20Sidecar!.blobs.length, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                "commitment = ${hex.encode(blob20Sidecar!.commitments[index].commitment)}"),
            Text("proof = ${hex.encode(blob20Sidecar!.proofs[index].proof)}"),
            Text("hash = ${hex.encode(blob20Sidecar!.blobHashes()[index])}"),
            const Divider(),
          ],
        );
      }).toList(),
    );
  }

  void _generateCommitmentAndProof() async {
    final blobs = <Blob>[];
    final commitments = <KzgCommitment>[];
    final proofs = <KzgProof>[];

    /// blob1
    // blobs.add(await Blob.randBlob());
    /// commitments hash with Blob contain all 0
    /// 010657f37554c781402a22917dee2f75def7ab966d7b770905398eba3c444014
    /// blob2
    blobs.add(Blob.zeroBlob()); // 全0

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

  void _blob20CommitmentAndProof() async {
    // https://etherscan.io/blob/0x01fc0a717777b0e983ce71eecae52ae24bdfd06459801ba5c20692ef11ca75c9?bid=706618
    const mintBlob20 =
        '{"protocol":"blob20","token":{"operation":"mint","ticker":"ETHS","amount":1000}}';

    final cborData = cborEncodeApplicationJson(mintBlob20);
    final blobs = cborDataToESIP8Blobs(cborData);
    final commitments = <KzgCommitment>[];
    final proofs = <KzgProof>[];

    for (var b in blobs) {
      final commit = await Kzg4844.kzgBlobToCommitment(b, kzgSetting!);
      commitments.add(commit);
      final p = await Kzg4844.kzgComputeBlobKzgProof(b, commit, kzgSetting!);
      proofs.add(p);
    }

    blob20Sidecar = BlobTxSidecar(
      blobs: blobs,
      commitments: commitments,
      proofs: proofs,
    );
    setState(() {});
  }
}
