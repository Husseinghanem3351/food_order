import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/modules/cart/widgets/cart_builder.dart';
import 'package:food_order2/modules/cart/widgets/empty_cart.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit
              .get(context)
              .cartModel
              .isNotEmpty,
          builder: (context) => const CartBuilder(),
          fallback: (context) => EmptyCart(),
        );
      },
    );
  }
}
