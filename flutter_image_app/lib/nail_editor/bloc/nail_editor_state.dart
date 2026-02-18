import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/layer_item.dart'; // 모델 import 필요

class NailEditorState extends Equatable {
  final Layer1Type layer1Type;
  final Color? layer1Color;
  final String? layer1ImagePath;
  final String? layer2PatternPath;
  final List<Layer3Item> layer3Items;
  final String? selectedItemId;
  final bool isSaving;

  const NailEditorState({
    this.layer1Type = Layer1Type.color,
    this.layer1Color = Colors.white,
    this.layer1ImagePath,
    this.layer2PatternPath,
    this.layer3Items = const [],
    this.selectedItemId,
    this.isSaving = false,
  });

  NailEditorState copyWith({
    Layer1Type? layer1Type,
    Color? layer1Color,
    String? layer1ImagePath,
    String? layer2PatternPath,
    List<Layer3Item>? layer3Items,
    String? selectedItemId,
    bool? isSaving,
  }) {
    return NailEditorState(
      layer1Type: layer1Type ?? this.layer1Type,
      layer1Color: layer1Color ?? this.layer1Color,
      layer1ImagePath: layer1ImagePath ?? this.layer1ImagePath,
      layer2PatternPath: layer2PatternPath,
      layer3Items: layer3Items ?? this.layer3Items,
      selectedItemId: selectedItemId,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [
    layer1Type,
    layer1Color,
    layer1ImagePath,
    layer2PatternPath,
    layer3Items,
    selectedItemId,
    isSaving,
  ];
}
