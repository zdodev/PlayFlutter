import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_memo_app/features/home/bloc/home_state.dart';

part 'home_event.freezed.dart';

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.selectedButton({required ButtonType buttonType}) =
      SelectedButton;
}
