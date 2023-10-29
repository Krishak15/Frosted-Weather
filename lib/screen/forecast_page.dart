import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weatherapp_frosted/icons/icons_provider.dart';
import 'package:weatherapp_frosted/screen/allforecasts_page.dart';
import 'package:weatherapp_frosted/widgets/chart/chart_widget.dart';

import '../bloc/weather_bloc_bloc.dart';
import '../formatters/dateformatter.dart';
import '../formatters/string_formatters.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class ForecastWeatherState {
  List<dynamic> list = [];
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.2),
                child: Container(
                    height: 300,
                    width: 250,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 86, 53, 179))),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.2),
                child: Container(
                    height: 300,
                    width: 250,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 118, 74, 237))),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.3),
                child: Container(
                    height: 250,
                    width: 300,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0))),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: const SizedBox(),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    Map<String, List<dynamic>> dailyForecasts = {};
                    for (var forecast in state.forecastWeather.list) {
                      String date = forecast.dtTxt.toString().substring(0, 10);
                      if (dailyForecasts[date] == null) {
                        dailyForecasts[date] = [forecast];
                      } else {
                        dailyForecasts[date]!.add(forecast);
                      }
                    }

                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: kToolbarHeight,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Forecast",
                                style: GoogleFonts.outfit(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, bottom: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Wind",
                                    style: GoogleFonts.outfit(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.forecastWeather.list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: index == 0 ? 20.0 : 2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GlassContainer.clearGlass(
                                        height: 120,
                                        width: 70,
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.purple.withOpacity(0.1),
                                        borderGradient: LinearGradient(
                                            colors: [
                                              Colors.white.withOpacity(0.6),
                                              Colors.white.withOpacity(0.1)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter),
                                        child: Container(
                                          height: 120,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.0),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            child: Column(
                                              children: [
                                                Transform.rotate(
                                                  angle: state
                                                          .forecastWeather
                                                          .list[index]
                                                          .wind
                                                          .deg *
                                                      math.pi /
                                                      180,
                                                  child: Image.asset(
                                                    "assets/icons/wind_arrow.png",
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  formatTime(state
                                                      .forecastWeather
                                                      .list[index]
                                                      .dtTxt
                                                      .toString()),
                                                  style: GoogleFonts.outfit(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  formatDateTime2(state
                                                      .forecastWeather
                                                      .list[index]
                                                      .dtTxt
                                                      .toString()),
                                                  style: GoogleFonts.outfit(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Temperature",
                                    style: GoogleFonts.outfit(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 5,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    "3 - 4 Days",
                                    style: GoogleFonts.outfit(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: TempChart(),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${dailyForecasts.length} days Forecast",
                                      style: GoogleFonts.poppins(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              const AllForecastsPage(),
                                        ));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "View all",
                                            style: GoogleFonts.outfit(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  String date =
                                      dailyForecasts.keys.elementAt(index);
                                  List<dynamic> forecasts =
                                      dailyForecasts[date]!;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, bottom: 15, top: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                formatDateTime5(date),
                                                style: GoogleFonts.outfit(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20.0),
                                                child: Divider(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: forecasts.map((forecast) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: GlassContainer.clearGlass(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.purple
                                                  .withOpacity(0.1),
                                              borderGradient: LinearGradient(
                                                  colors: [
                                                    Colors.white
                                                        .withOpacity(0.6),
                                                    Colors.white
                                                        .withOpacity(0.1)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.bottomRight),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                      height: 90,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: getWeatherIcon(
                                                            forecast
                                                                .weather[0].id,
                                                            80),
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Text(
                                                      '${forecast.main.temp.toStringAsFixed(0)}°C',
                                                      style: GoogleFonts.outfit(
                                                        color: Colors.white,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 180,
                                                        child: Text(
                                                          capitalize(forecast
                                                              .weather[0]
                                                              .description),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .outfit(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            QWeatherIcons
                                                                .tag_wind3
                                                                .iconData,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "${forecast.wind.speed} m/s",
                                                            style: GoogleFonts
                                                                .outfit(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.access_time,
                                                            size: 20,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            formatDateTime(
                                                                forecast.dtTxt
                                                                    .toString()),
                                                            style: GoogleFonts
                                                                .outfit(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 5.0, horizontal: 20),
                                      //   child: Divider(
                                      //       color:
                                      //           Colors.white.withOpacity(0.4)),
                                      // ),
                                    ],
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const AllForecastsPage(),
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "View all",
                                      style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 20,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Lottie.asset(
                                  'assets/lottie/weather_loading.json'),
                              Text(
                                'Hang tight,\nwe\'re fetching the weather for you!',
                                style: GoogleFonts.outfit(
                                    color: Colors.white, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CuDetailRows extends StatelessWidget {
  final String title;
  final String text;
  const CuDetailRows({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 20),
          ),
          Text(
            text,
            style: GoogleFonts.outfit(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

// String _getDayOfWeek(String date) {
//   DateTime dateTime = DateTime.parse(date);
//   List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//   return days[dateTime.weekday - 1];
// }
