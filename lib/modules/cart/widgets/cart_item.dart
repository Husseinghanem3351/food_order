import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_order2/layout/cubit/states.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../models/DataModel.dart';
import '../../../shared/constants/constants.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return insureDelete(context, product);
      },
      key: UniqueKey(),
      onDismissed: (direction) {
        HomeCubit.get(context).deleteItemOfCart(product);
      },
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) => Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  image: AssetImage(
                    product.image!,
                  )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                height: 1.5, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${product.price} SP',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.blueGrey,
                              height: 1.3,
                            ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: defaultColor(context),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (product.quantity == 1)
                              Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white10,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .minusProduct(product);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )),
                            if (product.quantity > 1)
                              Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    //backgroundBlendMode: BlendMode.screen,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white10,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context)
                                          .minusProduct(product);
                                    },
                                    icon: const Icon(Icons.remove),
                                  )),
                            if (product.quantity > 0)
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    '${product.quantity}',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ),
                            Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    HomeCubit.get(context).plusProduct(product);
                                  },
                                  icon: const Icon(Icons.add),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool?> insureDelete(BuildContext context, ProductModel product) =>
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Are you sure?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              content: Text(
                'Do you want to dismiss this item?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
              actions: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                TextButton(
                  child: const Text('Dismiss'),
                  onPressed: () {
                    HomeCubit.get(context).deleteItemOfCart(product);
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ));
