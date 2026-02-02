import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

enum ButtonType { first, second }

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({required ButtonType? buttonType}) = _HomeState;
}
