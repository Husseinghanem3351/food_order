import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/modules/home/widgets/shimmer_page.dart';
import 'package:food_order2/shared/components/components.dart';
import 'package:food_order2/shared/components/list_of_products.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/categories.dart';

class Home extends StatelessWidget {
  const Home({user, super.key});

  @override
  Widget build(BuildContext context) {
    // Size size =MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
            fallback: (context) => const LoadingListPage(),
            condition: HomeCubit.get(context).categoriesModel.isNotEmpty &&
                HomeCubit.get(context).productsModel.isNotEmpty,
            builder: (context) => Column(
                  children: [
                    SizedBox(
                        height: 60,
                        child: Categories(
                          catList: HomeCubit.get(context).categoriesModel,
                        )),
                    Expanded(
                        child: HomeCubit.get(context).categories?? ListView.builder(
                      itemBuilder: (context, index) => ListOfProducts(
                        products: HomeCubit.get(context).categoriesModel[index].products,
                        index: index,
                      ),
                      itemCount: HomeCubit.get(context).categoriesModel.length,
                    ))
                  ],
                ));
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
