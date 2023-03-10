import 'package:bloc_app/models/post_profile_models.dart';
import 'package:bloc_app/page/cubit_pofile/posts_state.dart';
import 'package:bloc_app/repository/posts_profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PostsCubit extends Cubit<PostsState>{

  PostsCubit(this.repository) : super (PostsInitial());

  int page = 1;

  bool endLoadPage = false;
  final PostProfileRepository repository;

  Future<void> loadPosts() async {
    if(state is PostsLoading) return;

    final currentState = state;

    List<DatumUser> oldPosts = <DatumUser>[];

    if(currentState is PostsLoaded){
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts,isFirst: page == 1));
 
    var newPosts = await repository.fetchPosts(page);

    final posts = (state as PostsLoading).oldPosts;

    posts.addAll(newPosts);

    emit(PostsLoaded(posts));  

  }

  Future<void> loadMorePosts() async {
    page++;
    if(state is PostsLoading) return;
    
    if(endLoadPage) return;

    final currentState = state;

    List<DatumUser> oldPosts = <DatumUser>[];

    if(currentState is PostsLoaded){
      oldPosts = currentState.posts; 
    }

    emit(PostsLoading(oldPosts));

    await Future.delayed(Duration(seconds: 1));

    List<DatumUser> newPosts = await repository.fetchPosts(page);
    if(newPosts.length == 0) endLoadPage =true;

    final posts =  oldPosts;

    posts.addAll(newPosts);

    emit(PostsLoaded(posts));  
  }
}