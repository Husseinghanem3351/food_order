import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/defaultTextBox.dart';
import '../../../shared/constants/constants.dart';

class SendOrDeleteButton extends StatelessWidget {
  const SendOrDeleteButton({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: defaultColor(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  // onPressed: onPressedSendRequest(context, total),
                  onPressed: (){
                    onPressedSendRequest(context, total);
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ارسال الطلب',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/whatsapp.png'),
                          radius: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    HomeCubit.get(context).deleteCart();
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'احذف السلة',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.delete),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

void Function()? onPressedSendRequest(BuildContext context, double total) {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormFieldState> textKey = GlobalKey<FormFieldState>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTextbox(
            textKey: textKey,
            onTap: () {
              TextSelection textSelection = TextSelection.fromPosition(
                  TextPosition(offset: controller.text.length));
              controller.selection = textSelection;
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
            onPressed: () => Navigator.of(context).pop(false),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              child: const Text('confirm'),
              onPressed: () async {
                HomeCubit.get(context).cartModel.forEach((element) {
                  sendCart.add({element.productName: element.quantity});
                });
                if (textKey.currentState!.validate()) {
                  final link = WhatsAppUnilink(
                    phoneNumber: '+963931890899',
                    text:
                        '$sendCart\n العنوان : ${controller.text}\nالسعر: $total',
                  );
                  await launchUrlString(link.toString(),
                          mode: LaunchMode.externalApplication)
                      .then((value) {
                    HomeCubit.get(context).deleteCart();
                    Navigator.of(context).pop(false);
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
  return null;
}
