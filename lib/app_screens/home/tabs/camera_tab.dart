import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app_utils/util_functions.dart';
import '../home_screen.dart';

late List<CameraDescription> cameras;

class CameraTab extends StatefulWidget {
  const CameraTab({Key? key}) : super(key: key);

  @override
  _CameraTabState createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  final List<Icon> _flashList = [
    Icon(Icons.flash_off),
    Icon(Icons.flash_on),
    Icon(Icons.flash_auto),
  ];

  double? _recordScale;
  int _flashSelected = 0;

  CameraController? _cameraController;

  final picker = ImagePicker();

  Future getImage() async {
    await picker.pickImage(source: ImageSource.camera);
  }

  Future getVideo() async {
    await picker.pickVideo(source: ImageSource.camera);
  }

  @override
  void initState() {
    super.initState();
    _recordScale = 1.0;
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium,
        enableAudio: false);
    checkPermission(
      context: context,
      permissionTitle: 'To capture photos and videos',
      permissionElement: [
        Permission.camera,
        Permission.storage,
      ],
    ).then((res) async {
      switch (res) {
        case 'GRANTED':
          _cameraController!.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
          });
          break;
        case 'NOT NOW':
          tabController!.animateTo(tabController!.previousIndex);
          break;
        case 'CONTINUE':
          await [Permission.camera, Permission.storage].request().then((value) {
            if (value.values.toList().every((element) => element.isGranted)) {
              _cameraController!.initialize().then((_) {
                if (!mounted) {
                  return;
                }
                setState(() {});
              });
            } else {
              tabController!.animateTo(tabController!.previousIndex);
            }
          });
          break;
        case 'SETTINGS':
          await openAppSettings().then((_) async {
            if (await Permission.camera.isGranted &&
                await Permission.storage.isGranted) {
              _cameraController!.initialize().then((_) {
                if (!mounted) {
                  return;
                }
                setState(() {});
              });
            } else {
              tabController!.animateTo(tabController!.previousIndex);
            }
          });
          break;
        default:
          break;
      }
    });
    /*checkCameraPermission(
      context: context,
    ).then((res) async {
      switch (res) {
        case "GRANTED":
          _cameraController.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
          });
          break;
        case "NOT NOW":
          tabController.animateTo(tabController.previousIndex);
          break;
        case "CONTINUE":
          await Permission.camera.request().then((value) {
            if (value.isGranted) {
              _cameraController.initialize().then((_) {
                if (!mounted) {
                  return;
                }
                setState(() {});
              });
            } else {
              tabController.animateTo(tabController.previousIndex);
            }
          });
          break;
        case "SETTINGS":
          await AppSettings.openAppSettings().then((_) async {
            if (await Permission.camera.isGranted) {
              _cameraController.initialize().then((_) {
                if (!mounted) {
                  return;
                }
                setState(() {});
              });
            } else {
              tabController.animateTo(tabController.previousIndex);
            }
          });
          break;
        default:
          break;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (!_cameraController!.value.isInitialized)
          Container(
            color: Colors.black,
            width: double.infinity,
            height: double.infinity,
          ),
        CameraPreview(
          _cameraController!,
        ),
        Positioned(
          bottom: 10.0,
          child: Text(
            'Hold for video, tap for photo',
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
              scale: _recordScale!,
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

  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
  }
}
