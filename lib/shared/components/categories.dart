import 'package:flutter/material.dart';
import 'package:food_order2/modules/Categories/category_products.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/DataModel.dart';
import '../constants/constants.dart';

class Categories extends StatelessWidget {
  const Categories({super.key, required this.catList});
 final List<CategoriesModel> catList;
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HomeCubit.get(context).categories != null
                ? (HomeCubit.get(context).currentIndex == index
                ? defaultColor(context)
                : Colors.grey[200])
                : Colors.grey[300],
          ),
          width: 120,
          height: 50,
          child: TextButton(
              child: Text(
                catList[index].categoryName!,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                HomeCubit.get(context).changeCategoriesItem(index);
                HomeCubit.get(context).categories = CategoryProducts(
                  products: catList[index].products,
                );
              }),
        ),
      ),
      itemCount: catList.length,
    );
  }
}
