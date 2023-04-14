import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_cubit.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Handling"),
      ),
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostErrorState) {
              SnackBar snackBar = SnackBar(content: Text(state.error), backgroundColor: Colors.red,);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
           if (state is PostLoadingState) {
             return const Center(child:  CircularProgressIndicator());
           }

           if( state is PostLoadedState){
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                PostModel post = state.posts[index];
                return ListTile(
                  title: Text(post.title.toString()),
                  subtitle: Text(post.completed.toString()),
                );
              },
              );
           }
           
           return const Center(
            child:  Text(" an error occour"),
           );
          },
        ),
      ),
    );
  }
}
