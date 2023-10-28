import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:weatherapp_frosted/widgets/chart_screen.dart';

import '../bloc/weather_bloc_bloc.dart';
import '../formatters/dateformatter.dart';
import '../formatters/string_formatters.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0.8 * kToolbarHeight, 0, 20),
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
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GlassContainer.clearGlass(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
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
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      CuDetailRows(
                                        title: "Humidity",
                                        text:
                                            "${state.curentWeather.humidity ?? "0"}%",
                                      ),
                                      CuDetailRows(
                                        title: "Wind Speed",
                                        text:
                                            "${state.curentWeather.windSpeed ?? "0"} m/s",
                                      ),
                                      CuDetailRows(
                                        title: "Cloudiness",
                                        text:
                                            "${state.curentWeather.cloudiness ?? "0"}%",
                                      ),
                                      CuDetailRows(
                                        title: "Rain (Last 3 hours)",
                                        text: state.curentWeather
                                                    .rainLast3Hours ==
                                                null
                                            ? "No Rain"
                                            : "${state.curentWeather.rainLast3Hours} mm",
                                      ),
                                      CuDetailRows(
                                        title: "Feels Like",
                                        text:
                                            "${formatCelsius(state.curentWeather.tempFeelsLike.toString())}°C",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: SizedBox(
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
                                          borderRadius:
                                              BorderRadius.circular(25),
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
                                                color: Colors.white
                                                    .withOpacity(0.0),
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
                            ),
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: TempChart(),
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
