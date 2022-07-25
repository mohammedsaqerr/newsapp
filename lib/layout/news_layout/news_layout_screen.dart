import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_layout/cubit/cubit.dart';
import 'package:newsapp/layout/news_layout/cubit/states.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/style/cubit_them.dart';


class NewsLayoutScreen extends StatelessWidget {
  const NewsLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var newsCubit = NewsCubit().get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(onPressed: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));

              } ,
                  icon: const Icon(Icons.search)),
              IconButton(onPressed: (){

                CubitThem().get(context).changTheme();
              }, icon: const Icon(Icons.brightness_5))
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: newsCubit.items,
            currentIndex: newsCubit.currentIndex,
            onTap: (index) {
              newsCubit.changIndex(index);
            },
          ),
          body:newsCubit.screens[newsCubit.currentIndex],

        );
      },
    );
  }
}
// ?country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
