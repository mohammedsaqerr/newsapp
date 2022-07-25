
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_layout/cubit/cubit.dart';
import 'package:newsapp/layout/news_layout/cubit/states.dart';

import '../../shared/components/components.dart';
import '../webview/webview_screen.dart';

class SearchScreen extends StatelessWidget {
  var searchTextEdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit().get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: searchTextEdController,
                  decoration: InputDecoration(
                      labelText: 'Search',

                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'NoAmg Search';
                    }
                    return null;
                  },
                  onChanged: (value) {

                    NewsCubit().get(context).getSearch(value: value);
                  },
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: list.isNotEmpty,
                    builder: (context) => ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildNews(
                            onTap: (){
                              WebViewScreen(url: list[index]['url'], );
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
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
