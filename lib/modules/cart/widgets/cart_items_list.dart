import 'package:flutter/material.dart';

import '../../../layout/cubit/cubit.dart';
import 'cart_item.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => CartItem(
        product: HomeCubit.get(context).cartModel[index],
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          height: 1,
          color: Colors.grey,
        ),
      ),
      itemCount: HomeCubit.get(context).cartItems,
    );
  }
}
