import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/layout/news_app/cubit/cubit.dart';
// import 'package:untitled/layout/news_app/cubit/states.dart';

import '../../layout/news_app/cubit/cubit.dart';
import '../../layout/news_app/cubit/states.dart';
import '../../shared/componants/componants.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state){} ,
      builder: (context, state){

        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                  top: 0.0,
                  end: 20.0,
                  bottom: 10.0 ,
                ),
                child: PhysicalModel(
                  color: Theme.of(context).primaryColorLight,
                  elevation: 4,
                  shadowColor: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(20),
                  child: defaultFormFieldSearch(
                    radius: 20.0,
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    },
                    context: context,
                    controller: searchController,
                    type: TextInputType.text,
                    hint_label: 'Search',
                    prefix: Icons.search,
                  ),
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),

            ],
          ),
        );
      },
    );
  }
}
