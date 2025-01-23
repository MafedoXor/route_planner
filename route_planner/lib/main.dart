import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:route_planner/models/route_model.dart';
import 'package:route_planner/screens/plan_route/plan_route_screen.dart';
import 'package:route_planner/screens/results/results_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            borderSide: BorderSide(color: Colors.blueGrey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey,
            minimumSize: const Size(double.infinity, 44),
            side: BorderSide(
              color: Colors.grey,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
      builder: (context, child) {
        final content = GestureDetector(
          onTap: () {
            final currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: child,
        );

        return content;
      },
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const PlanRouteScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/results') {
          final args = settings.arguments as RouteModel;

          return MaterialPageRoute(
            builder: (context) => ResultsScreen(
              routeModel: args,
            ),
          );
        }

        return null;
      },
    );
  }
}
