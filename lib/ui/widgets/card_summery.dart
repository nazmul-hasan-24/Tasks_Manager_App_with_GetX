import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String count, title;
  const SummaryCard({
    super.key,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(count,style: Theme.of(context).textTheme.titleLarge,),
                 Text(title,style: Theme.of(context).textTheme.bodyLarge,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}