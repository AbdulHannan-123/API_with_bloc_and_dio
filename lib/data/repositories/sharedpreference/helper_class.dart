import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/post_model.dart';

class PostModelStorage {
  static const String key = 'postModels';

  // Save a single PostModel to shared preferences
  static Future<bool> addPostModel(PostModel postModel) async {
    final List<PostModel> existingPostModels = await getPostModels();
    existingPostModels.add(postModel);
    return await savePostModels(existingPostModels);
  }

  // Save List<PostModel> to shared preferences
  static Future<bool> savePostModels(List<PostModel> postModels) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonData = json.encode(postModels.map((model) => model.toJson()).toList());
    return await prefs.setString(key, jsonData);
  }

  // Retrieve List<PostModel> from shared preferences
  static Future<List<PostModel>> getPostModels() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonData = prefs.getString(key) ?? '[]';
    final List<dynamic> jsonList = json.decode(jsonData);
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }
}
