import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auto_route_app/data/models/memo.dart';
import 'package:my_auto_route_app/data/repositories/memo_repository.dart';

abstract class MemoEvent extends Equatable {
  const MemoEvent();

  @override
  List<Object> get props => [];
}

class LoadMemos extends MemoEvent {}

class AddMemo extends MemoEvent {
  final String title;
  final String content;

  const AddMemo(this.title, this.content);
}

abstract class MemoState extends Equatable {
  const MemoState();

  @override
  List<Object> get props => [];
}

class MemoInitial extends MemoState {}

class MemoLoading extends MemoState {}

class MemoLoaded extends MemoState {
  final List<Memo> memos;

  const MemoLoaded(this.memos);

  @override
  List<Object> get props => [memos];
}

class MemoOperationSuccess extends MemoState {}

class MemoBloc extends Bloc<MemoEvent, MemoState> {
  final MemoRepository _repository;

  MemoBloc({required MemoRepository repository})
    : _repository = repository,
      super(MemoInitial()) {
    on<LoadMemos>(_onLoadMemos);
    on<AddMemo>(_onAddMemo);
  }

  Future<void> _onLoadMemos(LoadMemos event, Emitter<MemoState> emit) async {
    emit(MemoLoading());
    final memos = await _repository.getMemos();
    emit(MemoLoaded(memos));
  }

  Future<void> _onAddMemo(AddMemo event, Emitter<MemoState> emit) async {
    emit(MemoLoading());
    await _repository.addMemo(event.title, event.content);
    emit(MemoOperationSuccess());
  }
}
