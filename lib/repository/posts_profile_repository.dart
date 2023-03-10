import 'package:bloc_app/models/post_profile_models.dart';
import 'package:bloc_app/service/post_profile_service.dart';

class PostProfileRepository{

  final PostProfileSevice postProfileSevice;

  PostProfileRepository(this.postProfileSevice); 
  
  Future<List<DatumUser>> fetchPosts(int page) async {
    final posts = await postProfileSevice.getPost(page);
    return PostProfileModels.fromJson(posts).data!;
  }
  
}