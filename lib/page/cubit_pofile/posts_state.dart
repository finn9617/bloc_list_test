import 'package:bloc_app/models/post_profile_models.dart';
import 'package:bloc_app/page/post_profile.dart';

abstract class PostsState{}

class PostsInitial extends PostsState{}

class PostsLoaded extends PostsState{
  final List<DatumUser> posts;

  PostsLoaded(this.posts);
} 

class PostsLoading extends PostsState{
  final List<DatumUser>  oldPosts;
  final bool isFirst;
  PostsLoading(this.oldPosts, {this.isFirst = false});
}