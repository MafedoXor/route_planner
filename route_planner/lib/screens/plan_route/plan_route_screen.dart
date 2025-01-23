import 'package:flutter/material.dart';
import 'package:route_planner/api/network_service.dart';
import 'package:route_planner/models/route_model.dart';

class PlanRouteScreen extends StatefulWidget {
  const PlanRouteScreen({super.key});

  @override
  State<PlanRouteScreen> createState() => _PlanRouteScreenState();
}

class _PlanRouteScreenState extends State<PlanRouteScreen> {
  final TextEditingController originController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isValidationChecked = false;

  @override
  void initState() {
    super.initState();

    originController.text = 'accra';
    destinationController.text = 'lagos';
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();

    super.dispose();
  }

  void onChanged(String value) {
    if (isValidationChecked) {
      formKey.currentState!.validate();
    }
  }

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

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<RouteModel?> makeRequest() async {
    setLoading(true);

    final result = await NetworkService().getRoutes(
      originController.text,
      destinationController.text,
    );

    setLoading(false);

    return result;
  }

  // ignore: unused_element
  // we can group null distance value and calculate the route to the nearest turn
  // RouteModel? calculateRoute(RouteModel? model) {
  //   setLoading(true);
  //
  //   if (model != null) {
  //     // NormalizeRoute.normalize(model);
  //     return null;
  //   }
  //
  //   setLoading(false);
  //
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    const String title = 'Plan Route';
    const String originInputPlaceholder = 'Origin city';
    const String destinationInputPlaceholder = 'Destination city';
    const String buttonLoadingText = 'Searching route';
    const String buttonActiveText = 'Search route';

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  TextFormField(
                    enabled: !isLoading,
                    keyboardType: TextInputType.text,
                    controller: originController,
                    onChanged: onChanged,
                    validator: validateInputs,
                    decoration:
                        InputDecoration(labelText: originInputPlaceholder),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    enabled: !isLoading,
                    keyboardType: TextInputType.text,
                    controller: destinationController,
                    onChanged: onChanged,
                    validator: validateInputs,
                    decoration:
                        InputDecoration(labelText: destinationInputPlaceholder),
                    textInputAction: TextInputAction.done,
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoading
                          ? Theme.of(context).primaryColor.withAlpha(100)
                          : Theme.of(context).primaryColor,
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (!formKey.currentState!.validate()) {
                              isValidationChecked = true;
                              return;
                            }

                            final result = await makeRequest();

                            // ignore: unused_element
                            // final calculatedResult = calculateRoute(result);

                            if (result != null) {
                              if (context.mounted) {
                                Navigator.pushNamed(
                                  context,
                                  '/results',
                                  arguments: result,
                                );
                              }
                              return;
                            }

                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  const String title = 'Route not found';
                                  const String content =
                                      'No route found for the given cities';
                                  const String button = 'OK';

                                  return AlertDialog(
                                    title: const Text(title),
                                    content: const Text(content),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(button),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                    child: isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
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
                          )
                        : Text(buttonActiveText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
