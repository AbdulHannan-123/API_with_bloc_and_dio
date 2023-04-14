import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/data/repositories/post_repository.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() :super(PostLoadingState()){
    fetchpost();
  }

  PostRepositories postRepositories = PostRepositories();

  void fetchpost()async{
    try {
      List<PostModel> posts =  await postRepositories.fetchpost();
      emit(PostLoadedState(posts));
    } on DioError catch (e) {
      if (e.type == DioErrorType.unknown) {
        emit(PostErrorState("the error is unknown"));
      }
    }
  }
  
}