import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/news_layout/cubit/cubit.dart';
import '../../layout/news_layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../webview/webview_screen.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit()
            .get(context)
            .sports;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder: (context) =>
              ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildNews(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                WebViewScreen(url: list[index]['url'],)));
                      },
                      context: context,
                      image: list[index]['urlToImage'],
                      title: list[index]['title'],
                      date: list[index]['publishedAt'],
                    );
                  }, separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[200],
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                );
              }, itemCount: list.length),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator(),),

        );
      },

    );
  }
}
