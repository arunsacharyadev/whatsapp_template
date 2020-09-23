import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_template/app_utils/util_functions.dart';

class CameraTab extends StatefulWidget {
  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
  }

  CameraController _cameraController;

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) return Container();
    return AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: CameraPreview(
        _cameraController,
      ),
    );
  }
}
