
import 'package:flutter/material.dart';
import 'package:food_order2/modules/home/widgets/shimmer_item.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  LoadingListPageState createState() => LoadingListPageState();
}

class LoadingListPageState extends State<LoadingListPage> {
  final bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              period: const Duration(seconds: 2),
              baseColor: Colors.grey[500]!.withOpacity(.4),
              highlightColor: Colors.grey[400]!.withOpacity(.3),
              enabled: _enabled,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.08,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.06,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.3,
                            ),
                          ),
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.7,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.85,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ShimmerItem(),
                                      ShimmerItem(),
                                      ShimmerItem(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        itemCount: 3,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}