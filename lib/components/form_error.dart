import 'package:Que/refer/size_config.dart';
import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(generror: errors[index])),
    );
  }

  Row formErrorText({String generror}) {
    return Row(
      children: [
        Icon(Icons.error_outline),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        Text(
          generror,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
