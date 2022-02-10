import 'package:dkan/components/const.dart';
import 'package:dkan/helpers/network/dio_helper.dart';
import 'package:dkan/helpers/network/end_points.dart';
import 'package:dkan/models/search_model.dart';
import 'package:dkan/views/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search({required String text}){

    emit(SearchLoadingState());
    
    DioHelper.postData(
      url: SEARCH,
      data: {'text': text},
      token: token!,
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}
