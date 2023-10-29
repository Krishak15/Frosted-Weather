import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weatherapp_frosted/bloc/weather_bloc_bloc.dart';

import '../formatters/dateformatter.dart';
import '../formatters/string_formatters.dart';
import '../icons/icons_provider.dart';

class AllForecastsPage extends StatefulWidget {
  const AllForecastsPage({super.key});

  @override
  State<AllForecastsPage> createState() => _AllForecastsPageState();
}

class ForecastWeatherState {
  List<dynamic> list = [];
}

class _AllForecastsPageState extends State<AllForecastsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "6 Days",
          style: GoogleFonts.outfit(
              color: Colors.white, fontSize: 26, fontWeight: FontWeight.w600),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(80)),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
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
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dailyForecasts.length,
                        itemBuilder: (context, index) {
                          String date = dailyForecasts.keys.elementAt(index);
                          List<dynamic> forecasts = dailyForecasts[date]!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Divider(
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: forecasts.map((forecast) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: GlassContainer.clearGlass(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.purple.withOpacity(0.1),
                                      borderGradient: LinearGradient(
                                          colors: [
                                            Colors.white.withOpacity(0.6),
                                            Colors.white.withOpacity(0.1)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.bottomRight),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              height: 90,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: getWeatherIcon(
                                                    forecast.weather[0].id, 80),
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Text(
                                              '${forecast.main.temp.toStringAsFixed(0)}°C',
                                              style: GoogleFonts.outfit(
                                                color: Colors.white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 180,
                                                child: Text(
                                                  capitalize(forecast
                                                      .weather[0].description),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.outfit(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    QWeatherIcons
                                                        .tag_wind3.iconData,
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${forecast.wind.speed} m/s",
                                                    style: GoogleFonts.outfit(
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                        .withOpacity(0.5),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    formatDateTime(forecast
                                                        .dtTxt
                                                        .toString()),
                                                    style: GoogleFonts.outfit(
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                            Lottie.asset('assets/lottie/weather_loading.json'),
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
              })
            ],
          ),
        ),
      ),
    );
  }
}
