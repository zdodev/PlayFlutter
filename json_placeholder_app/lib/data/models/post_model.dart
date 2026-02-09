import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
sealed class PostModel with _$PostModel {
  const PostModel._();

  const factory PostModel({
    required int id,
    required String title,
    required String body,
    @JsonKey(name: 'userId') int? userId,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  PostEntity toEntity() => .new(id: id, title: title, body: body);
}
