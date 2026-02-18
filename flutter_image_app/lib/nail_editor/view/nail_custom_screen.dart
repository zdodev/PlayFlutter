import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// 분리한 파일들을 import 합니다.
import '../bloc/nail_editor_bloc.dart';
import '../bloc/nail_editor_event.dart';
import '../bloc/nail_editor_state.dart';
import '../models/layer_item.dart';

class NailCustomScreen extends StatefulWidget {
  const NailCustomScreen({super.key});

  @override
  State<NailCustomScreen> createState() => _NailCustomScreenState();
}

class _NailCustomScreenState extends State<NailCustomScreen> {
  final GlobalKey _globalKey = GlobalKey(); // 캡처를 위한 키

  // 이미지 저장 함수
  Future<void> _saveImage() async {
    // 권한 요청 (Android 13+ 대응 필요)
    await [Permission.storage, Permission.photos].request();

    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        final result = await ImageGallerySaver.saveImage(
          byteData.buffer.asUint8List(),
          quality: 100,
          name: "nail_art_${DateTime.now().millisecondsSinceEpoch}",
        );
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('저장 완료!')));
        }
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('저장 실패')));
      }
    }
  }

  // 갤러리에서 사진 가져오기 (1층용)
  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<NailEditorBloc>().add(SelectLayer1Image(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("네일 커스텀"),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveImage),
        ],
      ),
      body: Column(
        children: [
          // --- 편집 영역 (네일 모양 마스크) ---
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: _globalKey, // 캡처 영역
                child: ClipRRect(
                  // 네일 팁 모양 (예시: 둥근 모서리)
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 200,
                    height: 350,
                    color: Colors.grey[200], // 기본 배경
                    child: BlocBuilder<NailEditorBloc, NailEditorState>(
                      builder: (context, state) {
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            // === 1층: 배경 (사진 or 컬러) ===
                            _buildLayer1(state),

                            // === 2층: 패턴 ===
                            _buildLayer2(state),

                            // === 3층: 스티커 & 텍스트 (Stack으로 쌓임) ===
                            ...state.layer3Items.map((item) {
                              return _buildDraggableItem(
                                context,
                                item,
                                state.selectedItemId == item.id,
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- 컨트롤 패널 ---
          _buildControlPanel(context),
        ],
      ),
    );
  }

  // 1층 레이어 빌더
  Widget _buildLayer1(NailEditorState state) {
    if (state.layer1Type == Layer1Type.color) {
      return Container(color: state.layer1Color);
    } else if (state.layer1Type == Layer1Type.image &&
        state.layer1ImagePath != null) {
      // 사진은 움직일 수 있어야 함 (InteractiveViewer 활용)
      return InteractiveViewer(
        panEnabled: true,
        minScale: 0.1,
        maxScale: 4.0,
        child: Image.file(
          File(state.layer1ImagePath!),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return const SizedBox();
  }

  // 2층 레이어 빌더
  Widget _buildLayer2(NailEditorState state) {
    if (state.layer2PatternPath != null) {
      return IgnorePointer(
        // 패턴은 터치 이벤트를 받지 않고 1층이 움직이거나 3층이 선택되게 함
        child: Opacity(
          opacity: 0.5, // 패턴 투명도 예시
          child: Image.asset(
            state.layer2PatternPath!,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => const SizedBox(), // 에셋 없을 때 방어
          ),
        ),
      );
    }
    return const SizedBox();
  }

  // 3층 아이템 빌더 (Drag, Scale, Rotate 로직)
  Widget _buildDraggableItem(
    BuildContext context,
    Layer3Item item,
    bool isSelected,
  ) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onTap: () {
          context.read<NailEditorBloc>().add(SelectItem(item.id));
        },
        // Scale & Rotate 제스처
        onScaleUpdate: (details) {
          if (!isSelected) return; // 선택된 것만 움직임

          context.read<NailEditorBloc>().add(
            UpdateLayer3Item(
              id: item.id,
              // 기존 위치 + 델타 (간단한 이동 구현)
              position: item.position + details.focalPointDelta,
              scale:
                  item.scale *
                  details.scale, // 실제로는 baseScale을 저장하고 계산해야 튀지 않음 (여기선 약식)
              rotation: item.rotation + details.rotation,
            ),
          );
        },
        child: Transform(
          transform: Matrix4.identity()
            ..scale(item.scale)
            ..rotateZ(item.rotation),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : null,
            ),
            child: item.isText
                ? Text(item.content, style: const TextStyle(fontSize: 20))
                : const Icon(
                    Icons.star,
                    size: 50,
                    color: Colors.amber,
                  ), // 스티커 예시 아이콘
          ),
        ),
      ),
    );
  }

  // 하단 컨트롤 패널
  Widget _buildControlPanel(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.white,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "배경(1층)"),
                Tab(text: "패턴(2층)"),
                Tab(text: "꾸미기(3층)"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 1층 컨트롤
                  ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(10),
                    children: [
                      IconButton(
                        icon: const Icon(Icons.photo),
                        onPressed: () => _pickImage(context), // 갤러리 호출
                      ),
                      _colorButton(context, Colors.red),
                      _colorButton(context, Colors.blue),
                      _colorButton(context, Colors.green),
                      _colorButton(context, Colors.black),
                    ],
                  ),
                  // 2층 컨트롤
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      TextButton(
                        onPressed: () => context.read<NailEditorBloc>().add(
                          SelectLayer2Pattern(null),
                        ),
                        child: const Text("없음"),
                      ),
                      // 패턴 에셋 예시 버튼 (실제 에셋 경로 필요)
                      // _patternButton(context, "assets/pattern1.png"),
                    ],
                  ),
                  // 3층 컨트롤
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.emoji_emotions),
                        label: const Text("스티커 추가"),
                        onPressed: () {
                          context.read<NailEditorBloc>().add(
                            AddLayer3Item("sticker_path", isText: false),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.text_fields),
                        label: const Text("텍스트 추가"),
                        onPressed: () {
                          context.read<NailEditorBloc>().add(
                            AddLayer3Item("Hello", isText: true),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () => context.read<NailEditorBloc>().add(SelectLayer1Color(color)),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
