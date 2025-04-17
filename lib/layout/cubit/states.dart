import 'package:dio/dio.dart';

class HomeState {}

class ChangeBottomNav extends HomeState{}

class ChangeQuantityState extends HomeState{}

class ChangeScreenState extends HomeState{}

class ChangeDarkModeState extends HomeState{}

class GetDataError extends HomeState{
  DioError error;
  GetDataError(this.error);
}

class GetDataLoading extends HomeState{}

class GetDataSuccess extends HomeState{}

class GetSearchDataLoading extends HomeState{}

class GetSearchDataSuccess extends HomeState{}

class RemoveDataOfCArt extends HomeState{}

class SignOutState extends HomeState{}

