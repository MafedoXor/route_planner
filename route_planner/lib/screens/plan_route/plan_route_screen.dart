import 'package:flutter/material.dart';
import 'package:route_planner/api/network_service.dart';
import 'package:route_planner/models/route_model.dart';
import 'package:route_planner/screens/plan_route/widgets/fill_route_form_widget.dart';
import 'package:route_planner/screens/plan_route/widgets/text_loading_state.dart';

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

    originController.text = 'Netanya';
    destinationController.text = 'Herzelia';
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();

    super.dispose();
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<RouteModel?> fetchRoutes() async {
    setLoading(true);

    late final RouteModel? route;

    try {
      route = await networkService.getRoutes(
        originController.text,
        destinationController.text,
      );
    } on Exception catch (e) {
      print(e);
    }

    setLoading(false);

    return route;
  }

  @override
  Widget build(BuildContext context) {
    const String title = 'Plan Route';
    const String buttonLoadingText = 'Searching route';
    const String buttonActiveText = 'Search route';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Expanded(
                child: FillRouteFormWidget(
                  globalKey: formKey,
                  isLoading: isLoading,
                  originController: originController,
                  destinationController: destinationController,
                ),
              ),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) {
                          isValidationChecked = true;
                          return;
                        }

                        final result = await fetchRoutes();
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
                    ? TextLoadingState(buttonLoadingText: buttonLoadingText)
                    : Text(buttonActiveText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
