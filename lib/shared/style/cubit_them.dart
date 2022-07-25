import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_layout/cubit/states.dart';
import 'package:newsapp/shared/network/remote/cache_helper.dart';

class CubitThem extends Cubit<NewsStates>{
  CubitThem():super(NewsInitialState());
  CubitThem get(context )=>BlocProvider.of(context);


  bool isDarkThem =true ;
  void changTheme({ bool ? fromShared} ){
    if(fromShared!=null){
  isDarkThem =fromShared;
  emit(ChangThemState());
    }else {
      isDarkThem=!isDarkThem;
    CacheHelper.setBoll(key: 'isDark', value: isDarkThem).then((value) {
        emit(ChangThemState());
      });
    }


  }

}