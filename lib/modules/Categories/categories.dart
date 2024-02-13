import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodOrder/layout/cubit/states.dart';
import 'package:foodOrder/models/DataModel.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';


class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.count(
            childAspectRatio: 1 / 1.25,
            mainAxisSpacing: 10,
            crossAxisSpacing: 2,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
              products.length,
                  (index) =>
                  buildProductItem(
                      context,
                      products[index],
                      index),
            ),
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          ),
        );
      },
    );
  }
}
