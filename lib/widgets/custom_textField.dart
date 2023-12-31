import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.typeClavier,
      this.label = "",
      this.hint = "",
      this.filterInput,
      this.validation,
      this.onsaved, this.icon, this.initialValue,
      });

  final TextInputType? typeClavier;
  final String label;
  final String hint;
  final IconData? icon;
  final List<TextInputFormatter>? filterInput;
  final String? Function(String?)? validation;
  final void Function(String?)? onsaved;
  final String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
    
      style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 18),
      keyboardType: typeClavier,
      inputFormatters: filterInput,
      initialValue: initialValue!=null? initialValue : null,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 15),
        fillColor: Colors.white,
        filled: true,
        label:Text(label),
        labelStyle: TextStyle(fontSize: 20),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 20),
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.red)),
      ),
      validator: validation,
      onSaved: onsaved,
    );
  }
}