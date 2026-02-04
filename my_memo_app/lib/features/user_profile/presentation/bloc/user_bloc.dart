import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_memo_app/features/user_profile/domain/usercases/get_user_profile_usecase.dart';
import 'package:my_memo_app/features/user_profile/presentation/bloc/user_event.dart';
import 'package:my_memo_app/features/user_profile/presentation/bloc/user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUsecase _getUserProfileUsecase;

  UserBloc(this._getUserProfileUsecase) : super(const Initial()) {
    on<Started>(_onStarted);
  }

  Future<void> _onStarted(Started event, Emitter<UserState> emit) async {
    emit(const Loading());
    final user = await _getUserProfileUsecase(event.userId);
    emit(Loaded(user));
  }
}
