import 'package:flutter/material.dart';
import 'package:food_order2/layout/cubit/states.dart';
import 'package:food_order2/modules/cart/widgets/cart_items_list.dart';
import 'package:food_order2/modules/cart/widgets/send_or_delete_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/cubit/cubit.dart';

class CartBuilder extends StatelessWidget {
  const CartBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight );
    double total = 0;
    HomeCubit.get(context).cartModel.forEach((element) {
      total += element.price! * element.quantity;
    });
    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:height-100,child: const CartItemsList()),
              Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    // TotalWidget(total: total),
                    SendOrDeleteButton(total: total),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





