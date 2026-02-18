import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NailEditorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectLayer1Color extends NailEditorEvent {
  final Color color;
  SelectLayer1Color(this.color);
}

class SelectLayer1Image extends NailEditorEvent {
  final String path;
  SelectLayer1Image(this.path);
}

class SelectLayer2Pattern extends NailEditorEvent {
  final String? path;
  SelectLayer2Pattern(this.path);
}

class AddLayer3Item extends NailEditorEvent {
  final String content;
  final bool isText;
  AddLayer3Item(this.content, {this.isText = false});
}

class UpdateLayer3Item extends NailEditorEvent {
  final String id;
  final Offset? position;
  final double? scale;
  final double? rotation;

  UpdateLayer3Item({
    required this.id,
    this.position,
    this.scale,
    this.rotation,
  });
}

class SelectItem extends NailEditorEvent {
  final String? id;
  SelectItem(this.id);
}
