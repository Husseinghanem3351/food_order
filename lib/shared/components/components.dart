import 'package:flutter/material.dart';
import 'package:food_order2/shared/network/local/cache_helper.dart';
import '../../layout/cubit/cubit.dart';
import '../../models/DataModel.dart';
import '../../modules/Categories/category_products.dart';
import '../../modules/product_detail/product_detail.dart';
import '../constants/constants.dart';

void showToast({
  required context,
  required String msg,
  Color color = Colors.white,
}) {
  const TextStyle textStyle = TextStyle(fontSize: 30, color: Colors.black);
  double textWidth =
      _textSize(msg, textStyle, MediaQuery.of(context).size.width).width;
  final SnackBar snackBarConst = SnackBar(
    width: textWidth,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    content: Text(
      msg,
      textAlign: TextAlign.center,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 15,
      ),
    ),
    duration: const Duration(
      seconds: 10,
    ),
    backgroundColor: color,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBarConst);
}

Size _textSize(String text, TextStyle style, double maxWidth) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: 1,
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  )..layout(minWidth: 70, maxWidth: maxWidth * 0.75);
  return textPainter.size;
}

void navigateTo({required context, required Widget screen}) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ));
}

void pushAndReplacement({required context, required Widget screen}) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => false,
  );
}

Widget buildProductItem(
    context, ProductModel product, int index, double height, double width) {
  product.quantity = CacheHelper.getData(key: 'quantity${product.id}') ?? 0;
  return InkWell(
    onTap: () {
      navigateTo(
          context: context,
          screen: ProductDetails(
              details: product.description!,
              url: product.image!,
              name: product.productName!));
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: height-50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: height,
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          width: width ,
                          child: Image(
                            fit: BoxFit.cover,
                            height: height - 50,
                            image: AssetImage(
                              product.image!,
                            ),
                          )
                          // child:  CachedNetworkImage(
                          //   placeholder: (context, url) => const CircularProgressIndicator(),
                          //   errorWidget: (context, url, error) => const CircularProgressIndicator(),
                          //   imageUrl: '$url${product.image!}',
                          //   fit: BoxFit.cover,
                          //   height: 150,
                          // ),
                          ),
                      const Spacer(),
                    ],
                  ),
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
                                //backgroundBlendMode: BlendMode.screen,
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
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: width * .9,
                child: Text(
                  product.productName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 6),
              child: SizedBox(
                width: width*.95,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    Text(
                      '${product.price}',
                      style: const TextStyle(
                        color: Colors.blueGrey,
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

Widget buildHome(context, List<CategoriesModel> catList, Size size) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildCategoriesItems(
                  data: catList[index], index: index, context: context);
            },
            itemCount: HomeCubit.get(context).categoriesModel.length,
          ),
        ),
        Expanded(
            child: HomeCubit.get(context).categories ??
                buildCategoriesAndProducts(context, catList, size)),
      ],
    );

Widget buildCategoriesItems(
    {required CategoriesModel? data, required context, required int index}) {
  return Padding(
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
            data!.categoryName!,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () {
            HomeCubit.get(context).changeCategoriesItem(index);
            HomeCubit.get(context).categories = CategoryProducts(
              products: data.products,
            );
          }),
    ),
  );
}

Widget buildCategoriesAndProducts(
    context, List<CategoriesModel>? data, Size size) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      if (data[index].products.isNotEmpty) {
        return buildListProducts(
            context: context, data: data[index], index: index, size: size);
      }
      return null;
    },
    itemCount: data!.length,
  );
}

Widget buildListProducts(
    {required context,
    required CategoriesModel data,
    required int index,
    required Size size}) {
  return Column(children: [
    Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            height: 40,
            padding: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              Text('${data.categoryName}'),
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
                      products: data.products,
                    );
                  },
                  child: const Text(
                    'عرض المزيد',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ),
            ]))),
    Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: size.height * 0.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => buildProductItem(
              context, data.products[index], index, size.height * 0.3, size.width*.4),
          itemCount: data.products.length,
        ),
      ),
    )
  ]);
}
