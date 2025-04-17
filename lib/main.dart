
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/cubit/cubit.dart';
import 'package:food_order2/layout/cubit/states.dart';
import 'package:food_order2/shared/bloc_observer.dart';
import 'package:food_order2/shared/constants/themes.dart';
import 'package:food_order2/shared/network/local/cache_helper.dart';
import 'package:food_order2/shared/network/remote/dioHelper.dart';

import 'layout/home_layout.dart';
import 'modules/Login/login.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer=MyBlocObserver();
  // await Firebase.initializeApp(
  //        options: const FirebaseOptions(
  //        apiKey: 'AIzaSyCdPLJdY5BAo9nF_3F5YEvz8LO3NuzcjBU',
  //        appId: '1:584422394968:android:c47c42ac0c28cc05200e2d',
  //        messagingSenderId: '584422394968',
  //        projectId: 'foodorder-c5f56'),
  // );
  await CacheHelper.init();
  final bool? isDark=CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isDark});
  final Widget widget=CacheHelper.getData(key:'token')!=null?const HomeLayout(): const Login();//login if you not login
  final bool? isDark;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> HomeCubit()..changeDarkMode(fromShared: isDark)..getDataApp(context)),
      ],
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: HomeCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: const HomeLayout(),
          );
        },
      ),
    );
  }
}

