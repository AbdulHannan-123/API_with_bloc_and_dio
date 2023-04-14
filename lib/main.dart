import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/data/repositories/post_repository.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_cubit.dart';
import 'package:calling_api_with_bloc_and_dio/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  PostRepositories postrepositories = PostRepositories();
  List<PostModel> postMaps = await postrepositories.fetchpost();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(),
      child:const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
