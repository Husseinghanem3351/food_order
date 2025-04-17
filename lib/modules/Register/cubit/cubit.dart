
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/home_layout.dart';
import 'package:food_order2/modules/Register/cubit/states.dart';
import 'package:food_order2/shared/network/local/cache_helper.dart';


class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister(
      context, {
        required String name,
        required String phone,
        required String password,
        required String email,
      }) {
    emit(RegisterLoadingState());
      CacheHelper.putData(key: 'token', value: 'token');
      CacheHelper.putData(key: 'email', value: email);
      emit(RegisterSuccessState());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeLayout(),
      ),
    );
    // FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(email: email, password: password)
    //     .then((value) {
    //   CacheHelper.putData(key: 'token', value: value.user!.uid);
    //   CacheHelper.putData(key: 'email', value: email);
    //   emit(RegisterSuccessState());
    //   Navigator.push(
    //       context,
    //        MaterialPageRoute(
    //            builder: (context) => const HomeLayout(),
    //        ),
    //   );
    // }).catchError((error) {
    //   showToast(
    //     context: context,
    //     msg: error.toString(),
    //     color:Colors.red,
    //   );
    //   emit(RegisterErrorState());
    //   //print(error);
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

