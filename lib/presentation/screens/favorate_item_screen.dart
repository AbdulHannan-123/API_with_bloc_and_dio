import 'package:calling_api_with_bloc_and_dio/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post_model.dart';
import '../../logic/cubit/post_cubit/post_cubit.dart';
import '../../logic/cubit/post_cubit/post_state.dart';

// ignore: must_be_immutable
class FavoriteItemScreen extends StatefulWidget {
   FavoriteItemScreen({super.key});

   

  @override
  State<FavoriteItemScreen> createState() => _FavoriteItemScreenState();

  
}


class _FavoriteItemScreenState extends State<FavoriteItemScreen> {

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     PostCubit.instance.fetchpostfromlocal();
    return  Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(onPressed: (){
        PostCubit.instance.fetchpost();
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back)),
      title:const Text("Favorite Item Screen"),
    ),
    body: BlocConsumer<PostCubit, PostState>(
      listener: (context, state) async {
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
            PostModel post = state.posts[index] ;
            return ListTile(
              title: Text(post.name ?? "****"),
              subtitle: Text(post.consistency.toString()),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                  postmap: post,
                  fromhome:false
                )));
              },
            );
          },
          );
       }
       
       return const Center(
        child:  Text(" an error occour"),
       );
      },
    ),
    );
  }
}