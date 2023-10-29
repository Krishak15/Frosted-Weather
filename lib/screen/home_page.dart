import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weatherapp_frosted/bloc/weather_bloc_bloc.dart';
import 'package:weatherapp_frosted/icons/icons_provider.dart';
import '../constants/weekday.dart';
import '../formatters/dateformatter.dart';
import '../formatters/string_formatters.dart';
import '../widgets/homeloading_screen.dart';
import '../widgets/homes_details_widgets.dart';
import '../widgets/marquee_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  context.read<WeatherBlocBloc>().add(const RefreshWeather());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0.5 * kToolbarHeight, 20, 20),
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
                    if (kDebugMode) {
                      print(state.curentWeather);
                    }
                    String dateString = state.curentWeather.sunrise.toString();
                    String dateStringSet =
                        state.curentWeather.sunset.toString();
                    String formattedSunriseTime = formatDateTime(dateString);
                    String formattedSunsetTime = formatDateTime(dateStringSet);
                    String weatherDesc = capitalize(
                        state.curentWeather.weatherDescription.toString());

                    // String formattedTime =
                    //     "${state.curentWeather.date!.hour.toString().padLeft(2, '0')}:${state.curentWeather.date!.minute.toString().padLeft(2, '0')}";
                    String formattedDate = state.curentWeather.date!.month
                        .toString()
                        .padLeft(2, '0');
                    int weekDay = state.curentWeather.date!.weekday;

                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.location_fill,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 22,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height: 40,
                                  //MARQUEE
                                  child: MarqueeText(
                                      text: state.reverseGeoModel.displayName ??
                                          "Hello!"),
                                ),
                              ],
                            ),
                            Text(
                              "${getWeekdayName(weekDay)}, $formattedDate",
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            GlassContainer.clearGlass(
                              height: 310,
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
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: SizedBox(
                                        height: 160,
                                        child: Center(
                                            child: getWeatherIcon(
                                                state.curentWeather
                                                    .weatherConditionCode!,
                                                200))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      '${state.curentWeather.temperature!.celsius!.toStringAsFixed(0)}°C',
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    weatherDesc,
                                    style: GoogleFonts.outfit(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            GlassContainer.clearGlass(
                              height: 240,
                              width: MediaQuery.of(context).size.height * 0.9,
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.purple.withOpacity(0.1),
                              borderGradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.6),
                                    Colors.white.withOpacity(0.1)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: HDetailsWidget(
                                            icon: QWeatherIcons
                                                .tag_low_humidity2.iconData,
                                            title: "Humidity",
                                            value:
                                                '${state.curentWeather.humidity.toString()}%',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: HDetailsWidget(
                                            icon: Icons.thermostat_outlined,
                                            title: "Feels like",
                                            value:
                                                '${formatCelsius(state.curentWeather.tempFeelsLike.toString())}°C',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: HDetailsWidget(
                                            icon: QWeatherIcons
                                                .tag_wind3.iconData,
                                            title: "Wind Speed",
                                            value:
                                                '${state.curentWeather.windSpeed.toString()} m/s',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: HDetailsWidget(
                                            icon: QWeatherIcons
                                                .tag_wind_warning.iconData,
                                            title: "Wind Gust",
                                            value:
                                                '${state.curentWeather.windGust.toString() == "null" ? "-" : state.curentWeather.windGust.toString()} m/s',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: HDetailsWidget(
                                            icon: QWeatherIcons
                                                .tag_sunny.iconData,
                                            title: "Sunrise",
                                            value: '$formattedSunriseTime AM',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: HDetailsWidget(
                                            icon: QWeatherIcons
                                                .tag_waning_crescent.iconData,
                                            title: "Sunset",
                                            value: '$formattedSunsetTime PM',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const HomeLoadingScreen();
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
