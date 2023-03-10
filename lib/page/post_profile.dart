// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'dart:ui';

import 'package:bloc_app/models/post_profile_models.dart';
import 'package:bloc_app/page/bloc_change_layout/change_layout_bloc.dart';
import 'package:bloc_app/page/cubit_pofile/posts_cubit.dart';
import 'package:bloc_app/page/cubit_pofile/posts_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostProfileView extends StatelessWidget {
  PostProfileView({super.key});
  
  final ScrollController scrollController = ScrollController();

  void setupScrollController(context){
    scrollController.addListener(() {
        if(scrollController.position.pixels != 10){
          BlocProvider.of<PostsCubit>(context).loadMorePosts();
        }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts(); 
    ChangeLayoutBloc changeLayout = BlocProvider.of<ChangeLayoutBloc>(context); 

    return Scaffold(
      appBar: AppBar(
        title: Text ("Bloc list profile"),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 22),
            child: InkWell(
              onTap: () => changeLayout.add(ChangeLayoutPressed()),
              child: BlocBuilder<ChangeLayoutBloc,bool>(
                builder:(context, layout) {
                  if(layout)
                  return Icon(
                    Icons.grid_view_outlined,
                    size: 30,
                  );
                  return Icon(
                    Icons.list,
                    size: 30,
                  );
                }
              ),
            ),
          )
        ],),
      body: listProfile()
    );
  }
 
  listProfile(){
    return BlocBuilder<ChangeLayoutBloc,bool>(
          builder:(context, layout) {
        return BlocBuilder<PostsCubit,PostsState>(
          builder:(context, state) {
            if(state is PostsLoading && state.isFirst){
              return _loadingIndicator();
            }
    
            List<DatumUser> posts = [];
    
            if(state is PostsLoading){
              posts = state.oldPosts;
            }else if(state is PostsLoaded){
              posts = state.posts;
            } 

            if(layout){ 
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                controller: scrollController,
                shrinkWrap: true,
                itemBuilder: ((context, index){
                  if(state is PostsLoading && index == posts.length)  
                  return Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: _loadingIndicator(),
                  ) ;
                  return  _profileGridView(posts[index], context);
                }), 
                itemCount: state is PostsLoading ? posts.length + 1 : posts.length
              );
            }
            return ListView.separated(
              controller: scrollController,
              itemBuilder: ((context, index) => _profileList(posts[index], context,state, index == posts.length-1)), 
              separatorBuilder: ((context, index) => Divider(color: Colors.grey[400],)), 
              itemCount: posts.length);
          }
        );
      }
    );
  }
  _profileList( DatumUser profile, BuildContext context, PostsState state,bool endList){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12).copyWith(top: 25,bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child:CachedNetworkImage(  
                      imageUrl: profile.avatar!,
                      placeholder: (context, url) => Container(height: 10,width: 10, child: CircularProgressIndicator(strokeWidth: 2,)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 12,right: 12),
                    child: Column(   
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${profile.firstName} ${profile.lastName}",
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                         Row(
                           children: [
                             Expanded(
                               child: Text(
                                "${profile.email} ",
                                style: TextStyle(fontSize: 16),
                        ),
                             ),
                           ],
                         ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
          ),
          Visibility(
            visible: endList && state is PostsLoading,
            child: Center(
              child: Container(
                height: 30,
                width: 30,
                margin: EdgeInsets.all(12),
                child: _loadingIndicator(),
              ),
            ) 
          )
        ],
      ),
    );
  }
  _profileGridView( DatumUser profile, BuildContext context ){
   
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child:CachedNetworkImage(  
                  imageUrl: profile.avatar!,
                  placeholder: (context, url) => Container(height: 10,width: 10, child: CircularProgressIndicator(strokeWidth: 2,)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12,right: 12,top: 16),
              child: Column(   
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${profile.firstName} ${profile.lastName}",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                          "${profile.email} ",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,

                  ),
                        ),
                      ],
                    ),
                ],
              ),
            ), 
          
          ],
        ),
      ),
    );
  }
  _loadingIndicator(){
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2,),
      ),
    );
  }
}