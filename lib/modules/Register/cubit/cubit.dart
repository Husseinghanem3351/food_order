
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodOrder/layout/home_layout.dart';

import 'package:foodOrder/modules/Register/cubit/states.dart';
import 'package:foodOrder/shared/components/components.dart';
import 'package:foodOrder/shared/network/local/cache_helper.dart';

import '../../../models/userModel.dart';

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

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.putData(key: 'token', value: value.user!.uid);
      CacheHelper.putData(key: 'email', value: email);
      emit(RegisterSuccessState());
      Navigator.push(
          context,
           MaterialPageRoute(
               builder: (context) => const HomeLayout(),
           ),
      );
    }).catchError((error) {
      showToast(
        context: context,
        msg: error.toString(),
        color:Colors.red,
      );
      emit(RegisterErrorState());
      //print(error);
    });}

  IconData passIcon = Icons.visibility;
  bool isPass = false;

  void changePassIcon() {
    isPass = !isPass;
    passIcon = isPass ? Icons.visibility_off : Icons.visibility;
    emit(ChangeVisibilityState());
  }
}

