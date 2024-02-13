import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodOrder/shared/components/components.dart';
import 'package:shimmer/shimmer.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class Home extends StatelessWidget {
  const Home({user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          fallback: (context) => const LoadingListPage(),
          condition: HomeCubit
              .get(context)
              .categoriesModel
              .isNotEmpty && HomeCubit
              .get(context)
              .productsModel
              .isNotEmpty,
          builder: (context) =>
              buildHome(
                context,
                HomeCubit
                    .get(context)
                    .categoriesModel,
              ),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is GetDataError) {
          showToast(
            context: context,
            msg: state.error.toString(),
            color: Colors.red,
          );
        }
      },
    );
  }
}


class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  LoadingListPageState createState() => LoadingListPageState();
}

class LoadingListPageState extends State<LoadingListPage> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Expanded(
            child: Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: Colors.grey[500]!.withOpacity(.4),
              highlightColor: Colors.grey[400]!.withOpacity(.3),
              enabled: _enabled,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.06,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.3,
                            ),
                          ),
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.7,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.85,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      shimmerProd(),
                                      shimmerProd(),
                                      shimmerProd(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        itemCount: 3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget shimmerProd() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black54
                ),
                height: 150,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .4,
              ),
              Center(
                child: Container(
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: 40,
                  child: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 120,
            height: 17,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

