import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/data/repositories/post_repository.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() :super(PostLoadingState());

  PostRepositories postRepositories = PostRepositories();

  void fetchpost()async{
    try {
      List<PostModel> posts =  await postRepositories.fetchpost();
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }
  
}