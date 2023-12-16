import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DigitalSignaturePage extends StatefulWidget {
  @override
  _DigitalSignaturePageState createState() => _DigitalSignaturePageState();
}

class _DigitalSignaturePageState extends State<DigitalSignaturePage> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  Uint8List? _imageData;
  ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Signature'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _handleClearButtonPressed,
                  child: Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: _handleSaveButtonPressed,
                  child: Text('Save'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            _imageData != null
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.memory(_imageData!),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void _handleClearButtonPressed() {
    // rawImage.value = null;

    _signaturePadKey.currentState!.clear();
  }

  Widget _buildImageView() => Container(
        width: 192.0,
        height: 96.0,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white30,
        ),
        child: ValueListenableBuilder<ByteData?>(
          valueListenable: rawImage,
          builder: (context, data, child) {
            if (data == null) {
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text('not signed yet (png)\nscaleToFill: false'),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.memory(data.buffer.asUint8List()),
              );
            }
          },
        ),
      );
  Future<void> _handleSaveButtonPressed() async {
    _buildImageView();
    RenderSignaturePad boundary = _signaturePadKey.currentContext
        ?.findRenderObject() as RenderSignaturePad;

    if (_imageData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please create a signature first')));
    } else {
      ui.Image image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        return;
      }
      setState(() {
        _imageData = byteData.buffer.asUint8List();
        // print("========= ${_imageData}");

        return;
      });
      final result = await ImageGallerySaver.saveImage(_imageData!);
      if (result['isSuccess']) {
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to save signature')));
      }
    }
  }
}
