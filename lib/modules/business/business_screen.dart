import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_layout/cubit/cubit.dart';
import 'package:newsapp/layout/news_layout/cubit/states.dart';
import 'package:newsapp/modules/webview/webview_screen.dart';
import 'package:newsapp/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit().get(context).business;
        return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return buildNews(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                                  url: list[index]['url'],
                                )));
                  },
                  context: context,
                  image: list[index]['urlToImage'],
                  title: list[index]['title'],
                  date: list[index]['publishedAt'],
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[200],
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                );
              },
              itemCount: list.length),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
