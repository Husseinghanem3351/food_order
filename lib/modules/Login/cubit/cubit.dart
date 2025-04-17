// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/modules/Login/cubit/states.dart';
import 'package:food_order2/shared/network/local/cache_helper.dart';
import '../../../layout/home_layout.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin(
      context, {
        required String email,
        required String password,
      }) {
    emit(LoginLoadingState());
    CacheHelper.putData(key: 'token', value: 'token');
    CacheHelper.putData(key: 'email', value: email);
    emit(LoginSuccessState());
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeLayout(),
        ));
    // FirebaseAuth.instance
    //     .signInWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //       CacheHelper.putData(key: 'token', value: value.user!.uid);
    //       CacheHelper.putData(key: 'email', value: value.user!.email);
    //   emit(LoginSuccessState());
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const HomeLayout(),
    //       ));
    // }).catchError((error) {
    //   showToast(
    //     context: context,
    //     msg: error.toString(),
    //     color: Colors.red,
    //   );
    //   emit(LoginErrorState());
    //   print(error);
    // });
  }

  IconData passIcon = Icons.visibility;
  bool isPass = false;

  void changePassIcon() {
    isPass = !isPass;
    passIcon = isPass ? Icons.visibility_off : Icons.visibility;
    emit(ChangeVisibilityState());
  }

}

