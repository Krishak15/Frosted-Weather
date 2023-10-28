import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp_frosted/bloc/weather_bloc_bloc.dart';
import 'package:weatherapp_frosted/screen/bottomnavbar.dart';
import 'package:weatherapp_frosted/services/location_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.light,
    ));
    final LocationProvider locationProvider = LocationProvider();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
          future: locationProvider.determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocProvider<WeatherBlocBloc>(
                create: (context) => WeatherBlocBloc()
                  ..add(FetchWeather(position: snapshot.data as Position)),
                child: const BottomNavBarClass(),
              );
            } else {
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Lottie.asset('assets/lottie/loc.json'),
                                Text(
                                  'Fetching Location...',
                                  style: GoogleFonts.outfit(
                                      color: Colors.white, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ]),
                  ));
            }
          }),
    );
  }
}
