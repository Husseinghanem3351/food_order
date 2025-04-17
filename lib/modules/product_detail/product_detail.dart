
import 'package:flutter/material.dart';


class ProductDetails extends StatelessWidget {
   const ProductDetails({
    Key? key,
    required this.url,
    required this.details,
     required this.name
  }) : super(key: key);
  final String url;
  final String details;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body:  Padding(
       padding: const EdgeInsets.all(20.0),
       child: Directionality(
         textDirection: TextDirection.rtl,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children:  [
             Image(
                 width: double.infinity,
                   height:MediaQuery.of(context).size.height*0.3,
                   fit: BoxFit.cover,
               image: AssetImage(
                 url,
               )
             ),
           //   CachedNetworkImage(
           //   imageUrl: url,
           //   width: double.infinity,
           //   height:MediaQuery.of(context).size.height*0.3,
           //   fit: BoxFit.cover,
           // ),
              const SizedBox(height: 10,),
              Text(
                name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(vertical: 15.0),
                   child: Text(
                       details,

                   ),
                 ),
             ),
              ),
         ],),
       ),
     ),
    );
  }
}
