import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/sharedpreference/helper_class.dart';

class DetailsScreen extends StatelessWidget {
  final PostModel postmap;
  final bool fromhome;
  const DetailsScreen({super.key, required this.postmap, required this.fromhome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("LITTLE DETAILS OF RECIPS"),
        actions: [
          fromhome
          ? IconButton(
            onPressed: () async{
              try {
                await PostModelStorage.addPostModel(postmap);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: Text("${postmap.name} is added"),
                ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    content: Text("$e")));
              }
          }, 
          icon:const Icon(Icons.favorite),)
          : Wrap()
        ],
      ),
      body: ListTile(
        title: Text(postmap.name??"****"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(postmap.consistency ??"*****************"),
            Text(postmap.original ??"*****************"),
          ],
        ),
      ),
    );
  }
}