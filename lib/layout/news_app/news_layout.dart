import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/layout/news_app/cubit/cubit.dart';
// import 'package:untitled/layout/news_app/cubit/states.dart';
// import 'package:untitled/shared/componants/componants.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../modules/new_search/search_screen.dart';
import '../../shared/componants/componants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'News App'
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      cubit.search=[];
                      navigateTo(context,SearchScreen(),);
                    },
                    icon: Icon(Icons.search)
                ),
                IconButton(
                    onPressed: (){
                      cubit.changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined)
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
    );
  }
}
