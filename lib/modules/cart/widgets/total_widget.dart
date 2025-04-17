import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key,required this.total});

  final double total;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Text(
              'total:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // const Spacer(),
            Text(
              '$total',
              style: const TextStyle(
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
