import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          "no internet connection !!!",
          style: TextStyle(color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
            fontSize: 20
          ),
          
        )
      ],
    ));
  }
}
