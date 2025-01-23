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
  // uncomment to use lazy loading
  // final NetworkService _networkService = NetworkService();
  // final ScrollController _scrollController = ScrollController();
  //
  // List<WeatherModel> _weatherData = [];
  // bool _isLoading = false;
  // int _currentIndex = 0;
  // static const int _batchSize = 8;
  //
  // Future<void> _loadNextBatch() async {
  //   if (_currentIndex >= widget.routeModel.steps.length) return;
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   final nextBatch = widget.routeModel.steps
  //       .map((step) => step.location)
  //       .toList()
  //       .skip(_currentIndex)
  //       .take(_batchSize)
  //       .toList();
  //
  //   try {
  //     for (var location in nextBatch) {
  //       final weather = await _networkService.getWeather(
  //         location,
  //       );
  //       _weatherData.add(weather);
  //     }
  //     _currentIndex += nextBatch.length;
  //   } catch (e) {
  //     print("Error fetching weather data: $e");
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _loadNextBatch();
  //
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels >=
  //             _scrollController.position.maxScrollExtent &&
  //         !_isLoading) {
  //       _loadNextBatch();
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              'Total distance: ${widget.routeModel.distance / 1000} km',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Total duration: ${widget.routeModel.duration ~/ 3600} hours ${widget.routeModel.duration % 3600 ~/ 60} minutes',
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
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                //uncomment to use lazy loading
                // controller: _scrollController,
                // itemCount: _weatherData.length + (_isLoading ? 1 : 0),
                itemCount: widget.routeModel.steps.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) {
                  //uncomment to use lazy loading
                  // if (index < _weatherData.length) {
                  //   final weather = _weatherData[index];
                  //
                  //   if (index == 0) {
                  //     return StepListTileWidget(
                  //       step: RouteStep(
                  //         direction: Direction.start,
                  //         location: widget.routeModel.steps[0].location,
                  //       ),
                  //       weatherModel: weather,
                  //     );
                  //   }
                  //
                  //   return StepListTileWidget(
                  //     step: widget.routeModel.steps[index],
                  //     weatherModel: weather,
                  //   );
                  // } else {
                  //   return Center(child: CircularProgressIndicator());
                  // }

                  if (index == 0) {
                    return StepListTileWidget(
                      step: RouteStep(
                        direction: Direction.start,
                        location: widget.routeModel.steps[0].location,
                      ),
                    );
                  }

                  return StepListTileWidget(
                    step: widget.routeModel.steps[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
