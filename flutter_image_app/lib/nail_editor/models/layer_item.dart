import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// 1층 레이어 타입 정의
enum Layer1Type { color, image, none }

// 3층 레이어 아이템 (스티커/텍스트) 모델
class Layer3Item extends Equatable {
  final String id;
  final String content;
  final bool isText;
  final Offset position;
  final double scale;
  final double rotation;

  const Layer3Item({
    required this.id,
    required this.content,
    this.isText = false,
    this.position = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
  });

  Layer3Item copyWith({Offset? position, double? scale, double? rotation}) {
    return Layer3Item(
      id: id,
      content: content,
      isText: isText,
      position: position ?? this.position,
      scale: scale ?? this.scale,
      rotation: rotation ?? this.rotation,
    );
  }

  @override
  List<Object?> get props => [id, content, isText, position, scale, rotation];
}
