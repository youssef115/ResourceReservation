import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key,this.value=false, required this.onchange,this.title=""});

final bool value;
final  void Function(bool?)? onchange;
final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Checkbox(
          value: value,
          onChanged: onchange
          ),
        Text(
        title,
        style:  TextStyle(
          fontSize: 18,
          color:Theme.of(context).colorScheme.primary
        ),
        ),
      ],
    );
  }
}