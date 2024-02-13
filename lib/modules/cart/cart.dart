import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/DataModel.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

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
          builder: (context) => cartBuilder(context),
          fallback: (context) => emptyCart(),
        );
      },
    );
  }

  Widget emptyCart() {
    return const SingleChildScrollView(
      child: Column(children: [
        Image(
          image: AssetImage('assets/images/emptyCart (2)-65337c6b.png'),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Text(
          'لم تتم اضافة منتجات الى السلة حتى الان',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }

  Widget cartBuilder(context) {
    double total = 0;
    HomeCubit
        .get(context)
        .cartModel
        .forEach((element) {
      total += element.price! * element.quantity;
    });
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.69,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildCartItem(
                          context, HomeCubit
                          .get(context)
                          .cartModel[index]),
                  separatorBuilder: (context, index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                  itemCount: HomeCubit
                      .get(context)
                      .cartItems),
            ),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.18,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      children: [
                        Text(
                          'total:',
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        const Spacer(),
                        Text(
                          '$total',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: defaultColor(context),
                        ),
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {
                                TextEditingController controller = TextEditingController();
                                final GlobalKey<FormFieldState> textKey = GlobalKey<FormFieldState>();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: defaultTextBox(
                                          textKey: textKey,
                                          onTap: () {
                                            TextSelection textSelection =
                                            TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: controller
                                                        .text.length));
                                            controller.selection =
                                                textSelection;
                                          },

                                          hintText: 'العنوان',
                                          controller: controller,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'الحقل مطلوب';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.2),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: TextButton(
                                            child: const Text('confirm'),
                                            onPressed: () async {
                                              HomeCubit
                                                  .get(context)
                                                  .cartModel
                                                  .forEach((element) {
                                                sendCart.add({
                                                  element.productName: element
                                                      .quantity
                                                });
                                              });
                                              if (textKey.currentState!
                                                  .validate()) {
                                                final link = WhatsAppUnilink(
                                                  phoneNumber: '+963931890899',
                                                  text:
                                                  '$sendCart\n العنوان : ${controller
                                                      .text}\nالسعر: $total',
                                                );
                                                await launchUrlString(
                                                    link.toString(),
                                                    mode: LaunchMode
                                                        .externalApplication
                                                ).then((value) {
                                                  HomeCubit.get(context)
                                                      .deleteCart();
                                                  Navigator.of(context).pop(
                                                      false);
                                                  sendCart = [];
                                                  controller.text = '';
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'ارسال طلب',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/whatsapp.png'),
                                      radius: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                HomeCubit.get(context).deleteCart();
                              },
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'احذف السلة',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(Icons.delete),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartItem(context, ProductModel product) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(
                    'Are you sure?',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                  content: Text(
                    'Do you want to dismiss this item?',
                    style: Theme
                        .of(context)
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
      },
      key: UniqueKey(),
      onDismissed: (direction) {
        HomeCubit.get(context).deleteItemOfCart(product);
      },
      child: Container(
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
                )
            ),
            // CachedNetworkImage(
            //   imageUrl: '$url${product.image!}',
            //   fit: BoxFit.cover,
            //   width: 120,
            //   height: 120,
            //   placeholder: (context, url) =>
            //       const Center(child: CircularProgressIndicator()),
            // ),
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(height: 1.5, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${product.price} SP',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
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
    );
  }
}
