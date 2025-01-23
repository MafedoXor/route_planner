import 'package:flutter/material.dart';

class FillRouteFormWidget extends StatefulWidget {
  final bool isLoading;
  final TextEditingController originController;
  final TextEditingController destinationController;
  final GlobalKey<FormState> globalKey;

  const FillRouteFormWidget({
    super.key,
    required this.globalKey,
    required this.isLoading,
    required this.originController,
    required this.destinationController,
  });

  @override
  State<FillRouteFormWidget> createState() => _FillRouteFormWidgetState();
}

class _FillRouteFormWidgetState extends State<FillRouteFormWidget> {
  String? validateInputs(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 2) {
      return 'This field should be at least 2 characters long';
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return 'This field should not contain numbers';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    const String originInputPlaceholder = 'Origin city';
    const String destinationInputPlaceholder = 'Destination city';

    return Form(
      key: widget.globalKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            enabled: !widget.isLoading,
            keyboardType: TextInputType.text,
            controller: widget.originController,
            validator: validateInputs,
            decoration: InputDecoration(labelText: originInputPlaceholder),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.always,
            enabled: !widget.isLoading,
            keyboardType: TextInputType.text,
            controller: widget.destinationController,
            validator: validateInputs,
            decoration: InputDecoration(labelText: destinationInputPlaceholder),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
