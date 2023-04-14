import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState{
  final List<PostModel> posts;
  PostLoadedState(this.posts);
}

class PostErrorState extends PostState{
  final String error;
  PostErrorState(this.error);
}