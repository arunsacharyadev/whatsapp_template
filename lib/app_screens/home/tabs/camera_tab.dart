import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_template/app_utils/util_functions.dart';

class CameraTab extends StatefulWidget {
  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  @override
  void initState() {
    super.initState();
    _recordScale = 1.0;
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

  List<Icon> _flashList = [
    Icon(Icons.flash_off),
    Icon(Icons.flash_on),
    Icon(Icons.flash_auto),
  ];

  double _recordScale;
  int _flashSelected = 0;

  CameraController _cameraController;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedImageFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImageFile != null) {
        _image = File(pickedImageFile.path);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  Future getVideo() async {
    final pickedVideoFile = await picker.getVideo(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) return Container();
    return Stack(
      alignment: Alignment.center,
      children: [
        CameraPreview(
          _cameraController,
        ),
        Positioned(
          bottom: 10.0,
          child: Text(
            "Hold for video, tap for photo",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 46.0,
          left: 46.0,
          child: IconButton(
            iconSize: 30.0,
            color: Colors.white,
            icon: _flashList[_flashSelected],
            onPressed: () {
              setState(() {
                if (_flashSelected == _flashList.length - 1) {
                  _flashSelected = 0;
                } else {
                  _flashSelected++;
                }
              });
            },
          ),
        ),
        Positioned(
          bottom: 35.0,
          child: GestureDetector(
            onTap: getImage,
            onLongPressStart: (longPressDetails) async {
              await getVideo();
              setState(() {
                _recordScale = 1.2;
              });
            },
            onLongPressEnd: (longPressDetails) {
              setState(() {
                _recordScale = 1.0;
              });
            },
            child: Transform.scale(
              scale: _recordScale,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: _recordScale == 1.2 ? Colors.redAccent : null,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 55.0,
          right: 55.0,
          child: SvgPicture.asset(
            'assets/icons/flip_camera.svg',
            color: Colors.white,
            width: 30.0,
            height: 30.0,
          ),
        ),
      ],
    );
  }
}
