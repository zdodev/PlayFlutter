import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_memo_app/features/user_profile/domain/entities/user_entity.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.initial() = Initial;
  const factory UserState.loading() = Loading;
  const factory UserState.loaded(UserEntity user) = Loaded;
  const factory UserState.error(String message) = Error;
}
