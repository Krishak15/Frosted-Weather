import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp_frosted/bloc/weather_bloc_bloc.dart';
import 'package:weatherapp_frosted/converters/color_converter.dart';

import '../constants/chart_colors.dart';
import '../formatters/dateformatter.dart';

class TempChart extends StatefulWidget {
  TempChart({super.key});

  final Color barBackgroundColor = AppColors.contentColorWhite.withOpacity(0.3);
  final Color barColor = const Color.fromARGB(255, 176, 147, 255);
  final Color touchedBarColor = Colors.orange;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<TempChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Temperature',
                  style: TextStyle(
                    color: AppColors.contentColorWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   'Grafik konsumsi kalori',
                //   style: TextStyle(
                //     color: AppColors.contentColorGreen.darken(),
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        //Mapping data from API response to Chart data
                        List<double> temperatures = state.forecastWeather.list
                            .map((weather) => weather.main.temp)
                            .toList();

                        List<DateTime> dates = state.forecastWeather.list
                            .map((weather) => weather.dtTxt)
                            .toList();

                        // print(temperatures);

                        return BarChart(
                          BarChartData(
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                fitInsideHorizontally: true,
                                tooltipBgColor:
                                    const Color.fromARGB(255, 62, 29, 155)
                                        .darken(),
                                tooltipHorizontalAlignment:
                                    FLHorizontalAlignment.center,
                                tooltipMargin: 5,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  DateTime date = dates[group.x.toInt()];

                                  return BarTooltipItem(
                                    '${formatDateTime3(date)}\n',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            '${temperatures[group.x.toInt()].toString()}°C',
                                        style: TextStyle(
                                          color: widget.touchedBarColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              touchCallback:
                                  (FlTouchEvent event, barTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      barTouchResponse == null ||
                                      barTouchResponse.spot == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = barTouchResponse
                                      .spot!.touchedBarGroupIndex;
                                });
                              },
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return getTitles(value, meta, dates);
                                  },
                                  reservedSize: 38,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    getTitlesWidget: (value, meta) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4),
                                        child: Text(
                                          "${value.toInt().toString()}°C",
                                          style: GoogleFonts.outfit(
                                            color: Colors
                                                .white, // Customize the color of the text
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                10, // Adjust the font size as needed
                                          ),
                                        ),
                                      );
                                    },
                                    showTitles: true,
                                    reservedSize: 30),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: showingGroups(temperatures),
                            gridData: FlGridData(
                              show: true,
                              drawHorizontalLine: true,
                              drawVerticalLine: false,
                              checkToShowHorizontalLine: (value) {
                                return showAllGrids(value);
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 12,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 45, // Left side tile value
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: [],
    );
  }

  List<BarChartGroupData> showingGroups(List<double> temperatures) =>
      List.generate(20, (i) {
        return makeGroupData(i, temperatures[i], isTouched: i == touchedIndex);
      });

  Widget getTitles(double value, TitleMeta meta, List<DateTime> dates) {
    TextStyle style = GoogleFonts.outfit(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    if (value >= 0 && value < dates.length) {
      text = Text(
        formatDateTime4(dates[value.toInt()]),
        style: style,
      );
    } else {
      text = Text('', style: style);
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}

// Widget getTitles2(
//   double value,
//   TitleMeta meta,
// ) {
//   const style = TextStyle(
//     color: Colors.white,
//     fontWeight: FontWeight.bold,
//     fontSize: 10,
//   );
//   Widget text;

//   text = Text(
//     meta.max.round().toString(),
//     style: style,
//   );

//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     space: 16,
//     child: ,];
//   );
// }

