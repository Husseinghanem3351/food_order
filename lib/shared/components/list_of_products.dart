import 'package:flutter/material.dart';
import 'package:food_order2/modules/Categories/category_products.dart';
import 'package:food_order2/shared/components/product_item.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/DataModel.dart';

class ListOfProducts extends StatelessWidget {
  const ListOfProducts({super.key, required this.products, required this.index});
  final List<ProductModel> products;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
               Text(HomeCubit.get(context).categoriesModel[index].categoryName!),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    HomeCubit.get(context).changeCategoriesItem(index);
                    HomeCubit.get(context).categories = CategoryProducts(
                      products: HomeCubit.get(context).categoriesModel[index].products,
                    );
                  },
                  child: const Text(
                    'show more',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(
          height:  172,
          child: ListView.separated(
            itemBuilder: (context, index) => ProductItem(product: products[index],),
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.symmetric(horizontal: 10))  ,
          ),
        ),
      ],
    );
  }
}
