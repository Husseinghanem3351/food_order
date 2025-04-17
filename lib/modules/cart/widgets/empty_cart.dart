import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SingleChildScrollView(
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
}

