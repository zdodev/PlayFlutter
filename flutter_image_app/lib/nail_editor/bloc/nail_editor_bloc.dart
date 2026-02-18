import 'package:flutter/material.dart'; // Offset 사용 위함
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../models/layer_item.dart';
import 'nail_editor_event.dart';
import 'nail_editor_state.dart';

class NailEditorBloc extends Bloc<NailEditorEvent, NailEditorState> {
  NailEditorBloc() : super(const NailEditorState()) {
    on<SelectLayer1Color>((event, emit) {
      emit(
        state.copyWith(
          layer1Type: Layer1Type.color,
          layer1Color: event.color,
          layer1ImagePath: null,
        ),
      );
    });

    on<SelectLayer1Image>((event, emit) {
      emit(
        state.copyWith(
          layer1Type: Layer1Type.image,
          layer1ImagePath: event.path,
          layer1Color: null,
        ),
      );
    });

    on<SelectLayer2Pattern>((event, emit) {
      emit(state.copyWith(layer2PatternPath: event.path ?? ""));
      // 로직상 null 처리를 위해 빈 문자열 혹은 실제 null 로직 보완 필요
    });

    on<AddLayer3Item>((event, emit) {
      final newItem = Layer3Item(
        id: const Uuid().v4(),
        content: event.content,
        isText: event.isText,
        position: const Offset(100, 150),
      );
      emit(
        state.copyWith(
          layer3Items: [...state.layer3Items, newItem],
          selectedItemId: newItem.id,
        ),
      );
    });

    on<UpdateLayer3Item>((event, emit) {
      final updatedItems = state.layer3Items.map((item) {
        if (item.id == event.id) {
          return item.copyWith(
            position: event.position,
            scale: event.scale,
            rotation: event.rotation,
          );
        }
        return item;
      }).toList();
      emit(state.copyWith(layer3Items: updatedItems));
    });

    on<SelectItem>((event, emit) {
      emit(state.copyWith(selectedItemId: event.id));
    });
  }
}
