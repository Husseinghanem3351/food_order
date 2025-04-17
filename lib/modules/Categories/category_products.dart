import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/cubit/states.dart';
import 'package:food_order2/models/DataModel.dart';
import 'package:food_order2/shared/components/product_item.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';


class CategoryProducts extends StatelessWidget {
  const CategoryProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView.count(
            childAspectRatio: (size.width/2-20) / 172,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
              products.length,
                  (index) =>
                  ProductItem(product: products[index],productWidth: size.width/2-20,),
            ),
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          ),
        );
      },
    );
  }
}
