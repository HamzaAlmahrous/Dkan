import 'package:dkan/helpers/network/dio_helper.dart';
import 'package:dkan/helpers/network/end_points.dart';
import 'package:dkan/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';

class DkanLoginCubit extends Cubit<DkanLoginStates> {
  DkanLoginCubit() : super(DkanLoginInitialState());

  static DkanLoginCubit get(context) => BlocProvider.of(context);

  DkanLoginModel dkanLoginModel = DkanLoginModel.empty();

  void userLogin({required String email, required String password}){

    emit(DkanLoginLoadingState());
    
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value){
      dkanLoginModel = DkanLoginModel.fromJson(value.data);
      emit(DkanLoginSuccessState(dkanLoginModel));
    }).catchError((error){
      print(error);
      emit(DkanLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool showPassword = true;

  void changePasswordVisibility() {
    showPassword = !showPassword;

    suffix = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(DkanChangePasswordVisisbilityState());
  }
}
