import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/data/repositories/post_repository.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit._privateConstructor()  :super(PostLoadingState()){
    fetchpost();
  }

  PostRepositories postRepositories = PostRepositories();
  static final PostCubit instance = PostCubit._privateConstructor();

  void fetchpost()async{
    try {
      List<PostModel> posts =  await postRepositories.fetchpost();
      emit(PostLoadedState(posts));
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      // ignore: deprecated_member_use
      if (e.type == DioErrorType.unknown) {
        emit(PostErrorState("the error is unknown"));
      }
    }
  }

  Future fetchpostfromlocal() async{
      List<PostModel> posts =  await postRepositories.fetchpostfromlocal();
      emit(PostLoadedState(posts));
    }


  
}