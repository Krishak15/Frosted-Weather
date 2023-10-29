import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp_frosted/bloc/weather_bloc_bloc.dart';
import 'package:weatherapp_frosted/converters/color_converter.dart';

import '../../constants/chart_colors.dart';
import '../../formatters/dateformatter.dart';

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
    return GlassContainer.clearGlass(
      height: 330,
      width: MediaQuery.of(context).size.width * 0.9,
      borderRadius: BorderRadius.circular(25),
      color: Colors.purple.withOpacity(0.1),
      borderGradient: LinearGradient(colors: [
        Colors.white.withOpacity(0.6),
        Colors.white.withOpacity(0.1)
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
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
                            touchTooltipData:
                                barTouchToolTipDatas(dates, temperatures),
                            touchCallback:
                                (FlTouchEvent event, barTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex =
                                    barTouchResponse.spot!.touchedBarGroupIndex;
                              });
                            },
                          ),
                          titlesData: titlesData(dates),
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
                        child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: Color.fromARGB(255, 202, 111, 255)),
                      );
                    }
                  },
                ),
              ),
              const Text(
                'Days',
                style: TextStyle(
                  color: AppColors.contentColorWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Title Datas
  FlTitlesData titlesData(List<DateTime> dates) {
    return FlTitlesData(
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
                padding: const EdgeInsets.only(right: 4),
                child: Text(
                  "${value.toInt().toString()}°C",
                  style: GoogleFonts.outfit(
                    color: Colors.white, // Customize the color of the text
                    fontWeight: FontWeight.bold,
                    fontSize: 10, // Adjust the font size as needed
                  ),
                ),
              );
            },
            showTitles: true,
            reservedSize: 30),
      ),
    );
  }

  //Tooltip Data
  BarTouchTooltipData barTouchToolTipDatas(
      List<DateTime> dates, List<double> temperatures) {
    return BarTouchTooltipData(
      fitInsideHorizontally: true,
      tooltipBgColor: const Color.fromARGB(255, 62, 29, 155).darken(),
      tooltipHorizontalAlignment: FLHorizontalAlignment.center,
      tooltipMargin: 5,
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        DateTime date = dates[group.x.toInt()];

        return barToolTipItems(date, temperatures, group);
      },
    );
  }

  //Tooltip
  BarTooltipItem barToolTipItems(
      DateTime date, List<double> temperatures, BarChartGroupData group) {
    return BarTooltipItem(
      '${formatDateTime3(date)}\n',
      const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      children: <TextSpan>[
        TextSpan(
          text: '${temperatures[group.x.toInt()].toString()}°C',
          style: TextStyle(
            color: widget.touchedBarColor,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  //Chart Bar Properties
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

  //Assigning Temperature List to Chart Data
  List<BarChartGroupData> showingGroups(List<double> temperatures) =>
      List.generate(20, (i) {
        return makeGroupData(i, temperatures[i], isTouched: i == touchedIndex);
      });

  //Chart bottom titles (Days)
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
