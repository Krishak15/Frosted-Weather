import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class MarqueeText extends StatelessWidget {
  final String text;
  const MarqueeText({
    super.key,
    required this.text,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Marquee(
      key: const ValueKey("marquee"),
      startAfter: const Duration(seconds: 30),
      fadingEdgeEndFraction: 0.35,
      fadingEdgeStartFraction: 0.02,
      showFadingOnlyWhenScrolling: false,
      text: text,
      style: GoogleFonts.poppins(
          wordSpacing: 1,
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: Colors.white),
      crossAxisAlignment: CrossAxisAlignment.center,
      blankSpace: 20.0,
      velocity: 60.0,
      pauseAfterRound: const Duration(seconds: 5),
      startPadding: 4.0,
      accelerationDuration: const Duration(seconds: 2),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }
}
