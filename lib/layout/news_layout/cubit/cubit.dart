
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_layout/cubit/states.dart';
import '../../../modules/business/business_screen.dart';
import '../../../modules/science/scien_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() :super (NewsInitialState());
  //Object
   NewsCubit get(context )=>BlocProvider.of(context);
  List<BottomNavigationBarItem> items  =[

    const BottomNavigationBarItem(icon: Icon(Icons.business),label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports),label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science),label: 'Science'),
  ];
  int currentIndex = 0;
   void changIndex(int index){

     currentIndex =index;
     if(index ==1){
       getSports();
     }
     if(index ==2){
       getScience();
     }
     emit(NewsBottomNavState());
   }
   List<Widget> screens = [

     const BusinessScreen(),
     const SportsScreen(),
     const ScienceScreen(),
   ];

   List<dynamic> business =[];
   void getBusiness(){
     emit(NewsGetBusinessLoadingState());
     DioHelper.getData(url: 'v2/top-headlines', query:
     {
       'country':'eg',
       'category':'business',
       'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
     }).then((value) {
       business =value.data['articles'];
       print(business[0]['title']);
       emit(NewsGetBusinessSuccessState());
     }).catchError((error){
       print ('error data');
       emit(NewsGetBusinessErrorState());
   });
   }
  List<dynamic> sports =[];
  void getSports(){
    if(sports.isEmpty){
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query:
      {
        'country':'eg',
        'category':'sports',
        'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        sports =value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print ('error data');
        emit(NewsGetSportsErrorState());
      });

    }else{

    }

  }
  List<dynamic> science =[];
  void getScience(){
    if(science.isEmpty){
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(url: 'v2/top-headlines', query:
      {
        'country':'eg',
        'category':'science',
        'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        science =value.data['articles'];

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print ('error data');
        emit(NewsGetScienceErrorState());
      });
    }else{

    }

  }


  List<dynamic> search =[];
  void getSearch({required String value}){
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything', query:
    {
      'q':'$value',
      'apikey':'65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search =value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print ('error data');
      emit(NewsGetSearchErrorState());
    });
    }



  }



