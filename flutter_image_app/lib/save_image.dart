import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';

// --- 데이터 모델: 2층 요소 (스티커 or 텍스트) ---
class Layer2Item {
  // 공통 속성 (위치, 크기, 회전)
  Offset position;
  double scale;
  double rotation;

  // 타입 구분 (스티커냐 텍스트냐)
  bool isText;

  // 데이터 (스티커면 아이콘 데이터, 텍스트면 문자열)
  IconData? iconData;
  String? textContent;
  Color color;

  Layer2Item({
    required this.position,
    this.scale = 1.0,
    this.rotation = 0.0,
    required this.isText,
    this.iconData,
    this.textContent,
    this.color = Colors.black,
  });
}

void main() {
  runApp(const MaterialApp(home: NailLayerScreen()));
}

class NailLayerScreen extends StatefulWidget {
  const NailLayerScreen({super.key});

  @override
  State<NailLayerScreen> createState() => _NailLayerScreenState();
}

class _NailLayerScreenState extends State<NailLayerScreen> {
  final GlobalKey _globalKey = GlobalKey();
  final ImagePicker _picker = ImagePicker();

  // ---------------------------------------------------
  // [핵심] 층(Layer)별 상태 변수 (단 1개만 존재)
  // ---------------------------------------------------

  // [1층: 배경] - 둘 중 하나만 유효함
  Color _layer1Color = Colors.white; // 기본값
  File? _layer1Image; // 사진이 있으면 이게 우선

  // [2층: 꾸미기] - 스티커 or 텍스트 중 하나만 존재
  Layer2Item? _layer2Item;

  // 제스처 임시 변수
  double _baseScale = 1.0;
  double _baseRotation = 0.0;

  // --- [기능 1] 1층: 배경색 설정 ---
  void _setLayer1Color(Color color) {
    setState(() {
      _layer1Image = null; // [중요] 사진 제거 (상호 배타)
      _layer1Color = color; // 색상 적용
    });
  }

  // --- [기능 2] 1층: 사진 설정 ---
  Future<void> _setLayer1Photo() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _layer1Image = File(pickedFile.path); // 사진 설정
        // 색상은 굳이 null로 안 해도, 렌더링 시 사진이 덮음
      });
    }
  }

  // --- [기능 3] 2층: 스티커 추가 ---
  void _setLayer2Sticker() {
    setState(() {
      // 기존 2층 요소(텍스트든 뭐든)를 덮어쓰기
      _layer2Item = Layer2Item(
        position: const Offset(150, 250),
        isText: false,
        iconData: Icons.star, // 별 스티커
        color: Colors.amber,
      );
    });
  }

  // --- [기능 4] 2층: 텍스트 추가 (다이얼로그 입력) ---
  void _setLayer2Text() {
    TextEditingController textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("텍스트 입력"),
        content: TextField(controller: textController),
        actions: [
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                setState(() {
                  // 기존 2층 요소 덮어쓰기
                  _layer2Item = Layer2Item(
                    position: const Offset(150, 250),
                    isText: true,
                    textContent: textController.text,
                    color: Colors.black,
                  );
                });
              }
              Navigator.pop(context);
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  // 저장 함수 (생략 가능하나 동작 확인용 유지)
  Future<void> _saveImage() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (byteData != null) {
        await Gal.putImageBytes(byteData.buffer.asUint8List());
        if (mounted)
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('저장됨!')));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2-Layer System'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveImage),
        ],
      ),
      body: Column(
        children: [
          // ------------------------------------------
          // 캔버스 영역 (Stack 구조)
          // ------------------------------------------
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  width: 300,
                  height: 500,
                  // 1층 렌더링 로직: 이미지가 있으면 이미지, 없으면 컬러
                  decoration: BoxDecoration(
                    color: _layer1Image == null ? _layer1Color : null,
                    image: _layer1Image != null
                        ? DecorationImage(
                            image: FileImage(_layer1Image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      // [1층]은 Container decoration으로 처리했으므로 Stack child 불필요
                      // (만약 손 모델 이미지가 별도로 필요하면 여기에 추가)

                      // [2층] 렌더링 로직: _layer2Item이 null이 아닐 때만 그림
                      if (_layer2Item != null)
                        Positioned(
                          left: _layer2Item!.position.dx,
                          top: _layer2Item!.position.dy,
                          child: GestureDetector(
                            onScaleStart: (details) {
                              _baseScale = _layer2Item!.scale;
                              _baseRotation = _layer2Item!.rotation;
                            },
                            onScaleUpdate: (details) {
                              setState(() {
                                _layer2Item!.position +=
                                    details.focalPointDelta;
                                _layer2Item!.scale = _baseScale * details.scale;
                                _layer2Item!.rotation =
                                    _baseRotation + details.rotation;
                              });
                            },
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..scale(_layer2Item!.scale)
                                ..rotateZ(_layer2Item!.rotation),

                              // 텍스트인지 스티커인지 확인하여 그리기
                              child: _layer2Item!.isText
                                  ? Text(
                                      _layer2Item!.textContent!,
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: _layer2Item!.color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Icon(
                                      _layer2Item!.iconData,
                                      color: _layer2Item!.color,
                                      size: 80,
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ------------------------------------------
          // 컨트롤 패널
          // ------------------------------------------
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "1층: 배경 (하나만 선택됨)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _setLayer1Color(Colors.pinkAccent.withOpacity(0.5)),
                      child: const Text("핑크 배경"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _setLayer1Color(Colors.lightBlueAccent),
                      child: const Text("블루 배경"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _setLayer1Photo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("사진 배경"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "2층: 꾸미기 (하나만 존재함)",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _setLayer2Sticker,
                      icon: const Icon(Icons.star),
                      label: const Text("별 스티커"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: _setLayer2Text,
                      icon: const Icon(Icons.text_fields),
                      label: const Text("텍스트 입력"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
