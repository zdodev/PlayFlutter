import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_memo_app/features/home/bloc/home_event.dart';
import 'package:my_memo_app/features/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(buttonType: null)) {
    on<SelectedButton>(_onSelectedButton);
  }

  Future<void> _onSelectedButton(
    SelectedButton event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(buttonType: event.buttonType));
  }
}
