import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';

part 'post_bloc.freezed.dart';

@freezed
class PostEvent with _$PostEvent {
  const factory PostEvent.fetched() = _Fetched;
}

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _Loading;
  const factory PostState.success(List<PostEntity> posts) = _Success;
  const factory PostState.failure(String message) = _Failure;
}

@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase _getPostsUseCase;

  PostBloc(this._getPostsUseCase) : super(const PostState.initial()) {
    on<_Fetched>((event, emit) async {
      emit(const PostState.loading());
      try {
        // UseCase 실행
        final posts = await _getPostsUseCase();
        emit(PostState.success(posts));
      } catch (e) {
        emit(PostState.failure(e.toString()));
      }
    });
  }
}
