import 'package:flutter/material.dart';
import 'package:route_planner/enums/direction_enum.dart';
import 'package:route_planner/models/route_model.dart';
import 'package:route_planner/models/route_step_model.dart';
import 'package:route_planner/screens/results/widgets/step_list_tile_widget.dart';

class ResultsScreen extends StatefulWidget {
  final RouteModel routeModel;

  const ResultsScreen({super.key, required this.routeModel});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    const String titleText = 'Results';
    const String totalDistanceText = 'Total distance: ${0} km';
    const String totalDurationText = 'Total duration: ${0} hours ${1} minutes';

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(titleText),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      totalDistanceText.replaceFirst(
                        '${0}',
                        (widget.routeModel.distance / 1000).toStringAsFixed(2),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      totalDurationText
                          .replaceFirst(
                            '${0}',
                            (widget.routeModel.duration ~/ 3600).toString(),
                          )
                          .replaceFirst(
                            '${1}',
                            (widget.routeModel.duration % 3600 ~/ 60)
                                .toString(),
                          ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Total steps: ${widget.routeModel.steps.length}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return StepListTileWidget(
                      key: Key(
                        widget.routeModel.steps[index].location.toString(),
                      ),
                      step: RouteStep(
                        direction: Direction.start,
                        location: widget.routeModel.steps[index].location,
                      ),
                    );
                  }

                  return StepListTileWidget(
                    key:
                        Key(widget.routeModel.steps[index].location.toString()),
                    step: widget.routeModel.steps[index],
                  );
                },
                childCount: widget.routeModel.steps.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
