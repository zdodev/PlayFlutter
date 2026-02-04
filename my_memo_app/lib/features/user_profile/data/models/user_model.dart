import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_memo_app/features/user_profile/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    @JsonKey(name: 'first_name') required String username,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserEntity toEntity() => UserEntity(id: id, name: username, email: email);
}
