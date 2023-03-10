import 'package:bloc_app/page/cubit_pofile/posts_cubit.dart';
import 'package:bloc_app/page/post_profile.dart';
import 'package:bloc_app/repository/posts_profile_repository.dart';
import 'package:bloc_app/service/post_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'page/bloc_change_layout/change_layout_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo list bloc',
      theme: ThemeData(  
        primarySwatch: Colors.blue,
      ),
      home: const  MyHomePage(title: "Flutter Demo list bloc" ,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final PostProfileRepository repository = PostProfileRepository(PostProfileSevice());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsCubit(repository),
        ),
        BlocProvider(
          create: (context) => ChangeLayoutBloc(),
        ),
      ],
      child: PostProfileView(),
     );
  }
}
