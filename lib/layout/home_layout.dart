import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/search/search.dart';
import '../shared/components/components.dart';
import '../shared/constants/constants.dart';
import '../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<HomeCubit, HomeState>(
        builder: (context, state) {
          String? email = CacheHelper.getData(key: 'email');
          var cubit = HomeCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: RefreshIndicator(
              onRefresh: () async {
                cubit.getDataApp(context);
                await Future.delayed(const Duration(seconds: 1));
              },
              child: Scaffold(
                key: scaffoldKey,
                drawer: Drawer(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: SafeArea(
                    child: Column(children: [
                      UserAccountsDrawerHeader(
                        accountName: const Text('hussein ghanem'),
                        accountEmail: Text(email ?? ''),
                        currentAccountPicture: const CircleAvatar(
                          child: Text('hussein'),
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.5,
                        onPressed: () {
                          HomeCubit.get(context).signOut(context);
                        },
                        color: defaultColor(context),
                        child: Text(
                          'SignOut',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ]),
                  ),
                ),
                appBar: AppBar(
                  shadowColor: Colors.black,
                  leadingWidth: 104,
                  toolbarHeight: 60,
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          icon: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            cubit.changeDarkMode();
                          },
                          icon: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[100],
                            ),
                            child: Icon(
                              HomeCubit.get(context).isDark
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  title: InkWell(
                    onTap: () {
                      cubit.changeScreen(0);
                      HomeCubit.get(context).categories = null;
                    },
                    child: const Image(
                      image: AssetImage('assets/images/Logo-17a83221.png'),
                      height: 60,
                      width: 60,
                    ),
                  ),
                  actions: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        navigateTo(context: context, screen: const Search());
                      },
                      icon: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: Stack(alignment: Alignment.topLeft, children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              cubit.changeScreen(1);
                            },
                            icon: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100],
                                ),
                                child: const Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.black,
                                )),
                          ),
                          if (HomeCubit.get(context).cartItems != 0)
                            SizedBox(
                              height: 17,
                              width: 17,
                              child: CircleAvatar(
                                backgroundColor: HomeCubit.get(context).isDark
                                    ? Colors.black
                                    : Colors.grey,
                                child: Text(
                                  '${HomeCubit.get(context).cartItems}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                        ]),
                      ),
                    ),
                  ],
                ),
                body: cubit.homeScreens[cubit.currentScreen],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
