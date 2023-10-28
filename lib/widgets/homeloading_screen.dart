
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}