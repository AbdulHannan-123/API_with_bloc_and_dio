import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_cubit.dart';
import 'package:calling_api_with_bloc_and_dio/logic/cubit/post_cubit/post_state.dart';
import 'package:calling_api_with_bloc_and_dio/presentation/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorate_item_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  List<PostModel> recippost = [];
  List<PostModel> filterrecippost =[] ;


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("hello world");
    PostCubit.instance.fetchpost();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spoonacular"),
        actions: [
          IconButton(onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteItemScreen()));
          },
           icon:const Icon(Icons.favorite_border)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  setState(() {
                    filterrecippost = recippost
                    .where((item) => item.name!.toLowerCase().contains(value.toLowerCase()))
                    .toList();
                  });
                },
              ),
            ),
            Expanded(
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
                    itemCount: filterrecippost.isNotEmpty ? filterrecippost.length : state.posts.length,
                    itemBuilder: (context, index) {
                      recippost = state.posts;
                      PostModel post =filterrecippost.isNotEmpty ?  filterrecippost[index] : state.posts[index] ;
                      return ListTile(
                        title: Text(post.name ?? "****"),
                        subtitle: Text(post.consistency.toString()),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                            postmap: post,
                            fromhome: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
