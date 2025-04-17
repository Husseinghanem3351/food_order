import 'package:flutter/material.dart';
import 'package:food_order2/modules/product_detail/product_detail.dart';
import '../../layout/cubit/cubit.dart';
import '../../models/DataModel.dart';
import '../constants/constants.dart';
import 'components.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    this.productWidth,
  });

  final double? productWidth;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        navigateTo(
          context: context,
          screen: ProductDetails(
            url: product.image!,
            details: product.description!,
            name: product.productName!,
          ),
        );
      },
      child: Container(
        width: productWidth ?? width / 2.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(.2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Image(
                      height: 100,
                      fit: BoxFit.cover,
                      image: AssetImage(product.image!),
                      width: productWidth ?? width / 2.8,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Center(
                  child: Container(
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
                                  HomeCubit.get(context).minusProduct(product);
                                },
                                icon: const Icon(Icons.delete),
                              )),
                        if (product.quantity > 1)
                          Container(
                              width: 40,
                              height: 40,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                backgroundBlendMode: BlendMode.screen,
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white10,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).minusProduct(product);
                                },
                                icon: const Icon(Icons.remove),
                              )),
                        if (product.quantity > 0)
                          SizedBox(
                            width: 30,
                            child: Center(
                              child: Text(
                                '${product.quantity}',
                                // '5',
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                product.productName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${product.price}',
                    style: const TextStyle(
                        color: Colors.blueGrey, fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
