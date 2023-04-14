import 'dart:math';

import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/data/repositories/api/api.dart';
import 'package:dio/dio.dart';

class PostRepositories{

  API api = API();

  Future<List<PostModel>> fetchpost()async{
    try {
      Response response = await api.sendRequest.get('/todos');
      List<dynamic> postMaps = response.data;
      return postMaps.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw e;
    }
  }

}