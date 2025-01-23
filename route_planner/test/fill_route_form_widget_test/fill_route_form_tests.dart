import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:route_planner/screens/plan_route/widgets/fill_route_form_widget.dart';

void main() {
  group('FillRouteFormWidget Tests', () {
    late TextEditingController originController;
    late TextEditingController destinationController;
    late GlobalKey<FormState> formKey;

    setUp(() {
      originController = TextEditingController();
      destinationController = TextEditingController();
      formKey = GlobalKey<FormState>();
    });

    testWidgets('renders correctly with initial data', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FillRouteFormWidget(
              globalKey: formKey,
              isLoading: false,
              originController: originController,
              destinationController: destinationController,
            ),
          ),
        ),
      );

      expect(find.text('Origin city'), findsOneWidget);
      expect(find.text('Destination city'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('displays validation error for empty fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FillRouteFormWidget(
              globalKey: formKey,
              isLoading: false,
              originController: originController,
              destinationController: destinationController,
            ),
          ),
        ),
      );

      // Trigger validation by tapping the "next" action
      await tester.enterText(find.byType(TextFormField).first, '');
      await tester.pump();

      expect(find.text('This field is required'), findsExactly(2));
    });

    testWidgets('displays validation error for short input', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FillRouteFormWidget(
              globalKey: formKey,
              isLoading: false,
              originController: originController,
              destinationController: destinationController,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).first, 'A');
      await tester.pump();

      expect(
        find.text('This field should be at least 2 characters long'),
        findsOneWidget,
      );
    });

    testWidgets('displays validation error for input with numbers',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FillRouteFormWidget(
              globalKey: formKey,
              isLoading: false,
              originController: originController,
              destinationController: destinationController,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).first, 'City123');
      await tester.pump();

      expect(
        find.text('This field should not contain numbers'),
        findsOneWidget,
      );
    });

    testWidgets('fields are disabled when isLoading is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FillRouteFormWidget(
              globalKey: formKey,
              isLoading: true,
              originController: originController,
              destinationController: destinationController,
            ),
          ),
        ),
      );

      final originField = find.byType(TextFormField).first;
      final destinationField = find.byType(TextFormField).last;

      expect(tester.widget<TextFormField>(originField).enabled, isFalse);
      expect(tester.widget<TextFormField>(destinationField).enabled, isFalse);
    });

    testWidgets('form fields update controllers', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FillRouteFormWidget(
              globalKey: formKey,
              isLoading: false,
              originController: originController,
              destinationController: destinationController,
            ),
          ),
        ),
      );

      const testOrigin = 'New York';
      const testDestination = 'Los Angeles';

      await tester.enterText(find.byType(TextFormField).first, testOrigin);
      await tester.enterText(find.byType(TextFormField).last, testDestination);

      expect(originController.text, testOrigin);
      expect(destinationController.text, testDestination);
    });
  });
}
