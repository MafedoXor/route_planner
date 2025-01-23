import 'package:flutter/material.dart';

class TextLoadingState extends StatelessWidget {
  final String buttonLoadingText;

  const TextLoadingState({
    super.key,
    required this.buttonLoadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(buttonLoadingText),
      ],
    );
  }
}
