import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';

// Domain
// - Entity: 순수 데이터 객체
@freezed
sealed class PostEntity with _$PostEntity {
  const factory PostEntity({
    required int id,
    required String title,
    required String body,
  }) = _PostEntity;
}
