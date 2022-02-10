import 'package:dkan/helpers/network/dio_helper.dart';
import 'package:dkan/helpers/network/end_points.dart';
import 'package:dkan/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  DkanLoginModel dkanLoginModel = DkanLoginModel.empty();

  void userRegister({required String email, required String password, required String name, required String phone}){

    emit(RegisterLoadingState());
    
    DioHelper.postData(
      url: REGISTER,
      data: {'email': email, 'password': password, 'name': name, 'phone': phone},
    ).then((value){
      dkanLoginModel = DkanLoginModel.fromJson(value.data);
      emit(RegisterSuccessState(dkanLoginModel));
    }).catchError((error){
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool showPassword = true;

  void changePasswordVisibility() {
    showPassword = !showPassword;

    suffix = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterePasswordVisisbilityState());
  }
}
