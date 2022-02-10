import 'package:dkan/components/card.dart';
import 'package:dkan/components/default_format_field.dart';
import 'package:dkan/views/search/cubit/search_cubit.dart';
import 'package:dkan/views/search/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                actions: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 5.0),
                      margin: const EdgeInsets.only(top: 10.0, left: 20.0, right:  20.0),
                      child: defaultFormField(
                          controller: searchController,
                          label: 'search',
                          prefix: Ionicons.search,
                          context: context,
                          keyboardType: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            cubit.search(text: value);
                          }),
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is SearchLoadingState)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(100.0),
                            child: LinearProgressIndicator(),
                          ),
                        ),
                      if (state is SearchSuccessState)
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.85,
                            children: List.generate(
                              cubit.searchModel!.data.data.length,
                              (index) => MyCard(
                                product: cubit.searchModel!.data.data[index],
                                isSearch: true,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
