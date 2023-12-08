import 'package:calling_api_with_bloc_and_dio/data/models/post_model.dart';
import 'package:calling_api_with_bloc_and_dio/data/repositories/api/api.dart';
import 'package:dio/dio.dart';

import 'sharedpreference/helper_class.dart';

class PostRepositories{

  API api = API();

  Future<List<PostModel>> fetchpost()async{
    try {
      Response response = await api.sendRequest.get('/todos');
      List<dynamic> postMaps = response.data['extendedIngredients'];
      return postMaps.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw e;
    }
  }

  Future<List<PostModel>> fetchpostfromlocal()async{
    print("_____________________________________________________");
    try {      
      return await PostModelStorage.getPostModels();
    } catch (e) {
      throw e;
    }
  }

}