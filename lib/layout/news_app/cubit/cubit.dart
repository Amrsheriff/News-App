import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/layout/news_app/cubit/states.dart';
// import 'package:untitled/modules/science/science_screen.dart';
// import 'package:untitled/modules/sports/sports_screen.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../../modules/business/business_screen.dart';
import '../../../modules/science/science_screen.dart';
import '../../../modules/sports/sports_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'states.dart';


class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
        Icons.business,
        ),
        label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 1)
      getSports();
    if(index == 2)
      getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'1b44e7ed7a5c4035a86c2402bc342a7b'
      },
    ).then((value)
    {
      business = value.data['articles'];
      //print(business[0]['title']);
      //print(value.data['articles'][0]['title']);
      emit(NewsGetBusinessSuccessState());
    }
    ).catchError((error){
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());

    if (sports.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'sports',
            'apiKey':'1b44e7ed7a5c4035a86c2402bc342a7b'
            //'apiKey':'53812cc55d314d07a4c5e3236e83f1bf'
          },
        ).then((value)
        {
          sports = value.data['articles'];
          //print(business[0]['title']);
          //print(value.data['articles'][0]['title']);
          emit(NewsGetSportsSuccessState());
        }
        ).catchError((error){
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());

    if(science.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey':'1b44e7ed7a5c4035a86c2402bc342a7b'
          },
        ).then((value)
        {
          science = value.data['articles'];
          //print(business[0]['title']);
          //print(value.data['articles'][0]['title']);
          emit(NewsGetScienceSuccessState());
        }
        ).catchError((error){
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }else {
      emit(NewsGetScienceSuccessState());
    }

  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsAppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(
          key: 'isDark',
          value: isDark
      ).then((value) {
        getBusiness();
        getSports();
        getScience();
        emit(NewsAppChangeModeState());
      });
    }
  }

    List<dynamic> search = [];

    void getSearch(String value){
      if (value.isEmpty){
        search = [];
        emit(NewsGetSearchLoadingState());
      }

      // search = [];
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'1b44e7ed7a5c4035a86c2402bc342a7b'
        },
      ).then((value) {
        search = value.data['articles'];
        //print(search);
        //print(value.data['articles'][0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        //emit(NewsGetSearchErrorState(error.toString()));
      });
  }

}