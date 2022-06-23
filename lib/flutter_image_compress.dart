// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'const/resource.dart';
import 'time_logger.dart';

class ImageCompress extends StatefulWidget {
  const ImageCompress({Key? key}) : super(key: key);

  @override
  State<ImageCompress> createState() => _ImageCompressState();
}

class _ImageCompressState extends State<ImageCompress> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> compress() async {
    const img = AssetImage("img/img.jpg");
    // ignore: avoid_print
    print("pre compress");
    const config = ImageConfiguration();

    AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);

    final beforeCompress = data.lengthInBytes;
    print("beforeCompress = $beforeCompress");

    final result =
        await FlutterImageCompress.compressWithList(data.buffer.asUint8List());

    print("after = ${result.length}");
  }

  ImageProvider? provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image compress'),
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            child: Image(
              image: provider ?? const AssetImage("img/img.jpg"),
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            aspectRatio: 1 / 1,
          ),
          TextButton(
            child: const Text('CompressFile and rotate 180'),
            onPressed: _testCompressFile,
          ),
          TextButton(
            child: const Text('CompressAndGetFile and rotate 90'),
            onPressed: getFileImage,
          ),
          TextButton(
            child: const Text('CompressAsset and rotate 135'),
            onPressed: () => testCompressAsset("img/img.jpg"),
          ),
          TextButton(
            child: const Text('CompressList and rotate 270'),
            onPressed: compressListExample,
          ),
          TextButton(
            child: const Text('test compress auto angle'),
            onPressed: _compressAssetAndAutoRotate,
          ),
          TextButton(
            child: const Text('Test png '),
            onPressed: _compressPngImage,
          ),
          TextButton(
            child: const Text('Format transparent PNG'),
            onPressed: _compressTransPNG,
          ),
          TextButton(
            child: const Text('Restore transparent PNG'),
            onPressed: _restoreTransPNG,
          ),
          TextButton(
            child: const Text('Keep exif image'),
            onPressed: _compressImageAndKeepExif,
          ),
          TextButton(
            child: const Text('Convert to heic format and print the file url'),
            onPressed: _compressHeicExample,
          ),
          TextButton(
            child: const Text('Convert to webp format, Just support android'),
            onPressed: _compressAndroidWebpExample,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.computer),
        onPressed: () => setState(() => provider = null),
        tooltip: "show origin asset",
      ),
    );
  }

  Future<Directory> getTemporaryDirectory() async {
    return Directory.systemTemp;
  }

  void _testCompressFile() async {
    const img = AssetImage("img/img.jpg");
    print("pre compress");
    const config = ImageConfiguration();

    AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();
    print('dir = $dir');

    File file = createFile("${dir.absolute.path}/test.png");
    file.writeAsBytesSync(data.buffer.asUint8List());

    final result = await testCompressFile(file);

    if (result == null) return;

    ImageProvider provider = MemoryImage(result);
    this.provider = provider;
    setState(() {});
  }

  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }

  Future<String> getExampleFilePath() async {
    final img = AssetImage("img/img.jpg");
    print("pre compress");
    final config = new ImageConfiguration();

    AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();

    File file = createFile("${dir.absolute.path}/test.png");
    file.createSync(recursive: true);
    file.writeAsBytesSync(data.buffer.asUint8List());
    return file.absolute.path;
  }

  void getFileImage() async {
    const img = AssetImage("img/img.jpg");
    print("pre compress");
    const config = ImageConfiguration();

    AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();

    File file = createFile("${dir.absolute.path}/test.png");
    file.writeAsBytesSync(data.buffer.asUint8List());

    final targetPath = dir.absolute.path + "/temp.jpg";
    final imgFile = await testCompressAndGetFile(file, targetPath);

    if (imgFile == null) {
      return;
    }

    provider = FileImage(imgFile);
    setState(() {});
  }

  Future<Uint8List?> testCompressFile(File file) async {
    print("testCompressFile");
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 180,
    );
    print(file.lengthSync());
    print(result?.length);
    return result;
  }

  Future<File?> testCompressAndGetFile(File file, String targetPath) async {
    print("testCompressAndGetFile");
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 1024,
      minHeight: 1024,
      rotate: 90,
    );

    print(file.lengthSync());
    print(result?.lengthSync());

    return result;
  }

  Future testCompressAsset(String assetName) async {
    print("testCompressAsset");
    final list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );

    if (list == null) return;

    provider = MemoryImage(Uint8List.fromList(list));
    setState(() {});
  }

  Future compressListExample() async {
    final data = await rootBundle.load("img/img.jpg");

    final memory = await testComporessList(data.buffer.asUint8List());

    setState(() {
      this.provider = MemoryImage(memory);
    });
  }

  Future<Uint8List> testComporessList(Uint8List list) async {
    final result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1080,
      minWidth: 1080,
      quality: 96,
      rotate: 270,
      format: CompressFormat.webp,
    );
    print(list.length);
    print(result.length);
    return result;
  }

  void writeToFile(List<int> list, String filePath) {
    final file = File(filePath);
    file.writeAsBytes(list, flush: true, mode: FileMode.write);
  }

  void _compressAssetAndAutoRotate() async {
    final result = await FlutterImageCompress.compressAssetImage(
      R.IMG_AUTO_ANGLE_JPG,
      minWidth: 1000,
      quality: 95,
      // autoCorrectionAngle: false,
    );

    if (result == null) return;

    final u8list = Uint8List.fromList(result);
    provider = MemoryImage(u8list);
    setState(() {});
  }

  void _compressPngImage() async {
    final result = await FlutterImageCompress.compressAssetImage(
      R.IMG_HEADER_PNG,
      minWidth: 300,
      minHeight: 500,
    );

    if (result == null) return;

    final u8list = Uint8List.fromList(result);
    provider = MemoryImage(u8list);
    setState(() {});
  }

  void _compressTransPNG() async {
    final bytes =
        await getAssetImageUint8List(R.IMG_TRANSPARENT_BACKGROUND_PNG);
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 100,
      minWidth: 100,
      format: CompressFormat.png,
    );

    final u8list = Uint8List.fromList(result);
    provider = MemoryImage(u8list);
    setState(() {});
  }

  void _restoreTransPNG() async {
    provider = const AssetImage(R.IMG_TRANSPARENT_BACKGROUND_PNG);
    setState(() {});
  }

  void _compressImageAndKeepExif() async {
    final result = await FlutterImageCompress.compressAssetImage(
      R.IMG_AUTO_ANGLE_JPG,
      minWidth: 500,
      minHeight: 600,
      // autoCorrectionAngle: false,
      keepExif: true,
    );

    if (result == null) return;

    provider = MemoryImage(Uint8List.fromList(result));
    setState(() {});

    // final dir = (await path_provider.getTemporaryDirectory()).path;
    // final f = File("$dir/tmp.jpg");
    // f.writeAsBytesSync(result);
    // print("f.path = ${f.path}");
  }

  void _compressHeicExample() async {
    print("start compress");
    final logger = TimeLogger();
    logger.startRecoder();
    final tmpDir = (await getTemporaryDirectory()).path;
    final target = "$tmpDir/${DateTime.now().millisecondsSinceEpoch}.heic";
    final srcPath = await getExampleFilePath();
    final result = await FlutterImageCompress.compressAndGetFile(
      srcPath,
      target,
      format: CompressFormat.heic,
      quality: 90,
    );

    if (result == null) return;

    print("Compress heic success.");
    logger.logTime();
    print("src, path = $srcPath length = ${File(srcPath).lengthSync()}");
    print(
        "Compress heic result path: ${result.absolute.path}, size: ${result.lengthSync()}");
  }

  void _compressAndroidWebpExample() async {
    // Android compress very nice, but the iOS encode UIImage to webp is slow.
    final logger = TimeLogger();
    logger.startRecoder();
    print("start compress webp");
    final quality = 90;
    final tmpDir = (await getTemporaryDirectory()).path;
    final target =
        "$tmpDir/${DateTime.now().millisecondsSinceEpoch}-$quality.webp";
    final srcPath = await getExampleFilePath();
    final result = await FlutterImageCompress.compressAndGetFile(
      srcPath,
      target,
      format: CompressFormat.webp,
      minHeight: 800,
      minWidth: 800,
      quality: quality,
    );

    if (result == null) return;

    print("Compress webp success.");
    logger.logTime();
    print("src, path = $srcPath length = ${File(srcPath).lengthSync()}");
    print(
        "Compress webp result path: ${result.absolute.path}, size: ${result.lengthSync()}");

    provider = FileImage(result);
    setState(() {});
  }
}

Future<Uint8List> getAssetImageUint8List(String key) async {
  final byteData = await rootBundle.load(key);
  return byteData.buffer.asUint8List();
}

double calcScale({
  required double srcWidth,
  required double srcHeight,
  required double minWidth,
  required double minHeight,
}) {
  final scaleW = srcWidth / minWidth;
  final scaleH = srcHeight / minHeight;

  final scale = math.max(1.0, math.min(scaleW, scaleH));

  return scale;
}
