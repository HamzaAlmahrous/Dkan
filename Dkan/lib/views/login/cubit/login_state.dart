import 'package:dkan/models/login_model.dart';

///End of General states

abstract class DkanLoginStates {}

class DkanLoginInitialState extends DkanLoginStates {}

class DkanLoginLoadingState extends DkanLoginStates {}

class DkanLoginSuccessState extends DkanLoginStates {
  final DkanLoginModel dkanLoginModel;
  DkanLoginSuccessState(this.dkanLoginModel);
}

class DkanLoginErrorState extends DkanLoginStates {
  final String error;
  DkanLoginErrorState(this.error);
}

class DkanChangePasswordVisisbilityState extends DkanLoginStates {}
