import 'package:flutter/material.dart';

Widget getWeatherIcon(int conditionCode, double iconWidth) {
  bool isDay(DateTime time) {
    int hour = time.hour;
    return hour >= 6 && hour < 18;
  }

  DateTime now = DateTime.now();
  bool isDayTime = isDay(now);

  String iconImagePath;
  switch (conditionCode) {
    //Thunderstorm
    case 200:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/thunderstorm_lr.png'
          : 'assets/Sunset/rain_thunder.png';
      break;
    case 201:
    case 202:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/thunderrain.png'
          : 'assets/Sunset/shower_thunder.png';
      break;
    case 210:
    case 211:
    case 212:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Thunderstorm/Thunderstorm5.png'
          : 'assets/Sunset/heaavy_thunder.png';
      break;
    case 221:
      iconImagePath = 'assets/Clouds/Thunderstorm/Thunderstorm1.png';
      break;
    case 230:
    case 231:
    case 232:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/thunderrain.png'
          : 'assets/Sunset/shower_thunder.png';
      break;

    //Drizzle
    case 300:
      iconImagePath = 'assets/windy/drizzle_breeze.png';
      break;
    case 301:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/drizzle.png'
          : 'assets/Sunset/drizzle_night.png';
      break;
    case 302:
    case 310:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/light_rain.png'
          : "assets/Sunset/rain_night.png";
      break;
    case 311:
    case 312:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/heavy_rain.png'
          : "assets/Sunset/heavy_rain_night.png";
      break;
    case 313:
    case 314:
    case 321:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/shower.png'
          : "assets/Sunset/shower_night.png";
      break;
    //Rain
    case 500:
    case 501:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/drizzle.png'
          : "assets/Sunset/drizzle_night.png";
      break;
    case 502:
    case 503:
    case 504:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/heavy_rain.png'
          : "assets/Sunset/heavy_rain_night.png";
      break;
    case 511:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/rain_windy.png'
          : "assets/Sunset/clouds_wind.png";
      break;
    case 520:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/heavy_rain.png'
          : "assets/Sunset/heavy_rain_night.png";
      break;
    case 521:
    case 522:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Rain/shower.png'
          : "assets/Sunset/shower_night.png";
      break;
    case 531:
      iconImagePath = 'assets/windy/ragged_rain.png';
      break;

    //Snow
    case 600:
      iconImagePath = 'assets/windy/snow_breeze.png';
      break;
    case 601:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Snow/light_snow.png'
          : "assets/Sunset/snowy_night.png";
      break;
    case 602:
    case 611:
      iconImagePath = 'assets/Clouds/Snow/snow_breeze.png';
      break;
    case 612:
    case 613:
      iconImagePath = 'assets/lowtemp/heavy_snow.png';
      break;
    case 615:
    case 616:
    case 620:
    case 621:
    case 622:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Snow/snow_shower.png'
          : "assets/Sunset/heavy_snow_night.png";
      break;

    //Atmosphere
    case 701:
      iconImagePath = 'assets/windy/misty.png';
      break;
    case 711:
    case 721:
      iconImagePath = isDayTime
          ? 'assets/windy/breeze.png'
          : "assets/Sunset/breezy_night.png";
      break;
    case 731:
      iconImagePath = 'assets/Clouds/Thunderstorm/Thunderstorm2.png';
      break;
    case 741:
      iconImagePath = isDayTime
          ? 'assets/windy/breeze.png'
          : "assets/Sunset/breezy_night.png";
      break;
    case 751:
    case 761:
      iconImagePath =
          isDayTime ? 'assets/Sun/dust.png' : "assets/Sunset/windy_night.png";
      break;
    case 762:
    case 771:
      iconImagePath = 'assets/windy/breeze.png';
      break;
    case 781:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Thunderstorm/Thunderstorm3.png'
          : "assets/Sunset/lightning.png";
      break;
    //clear
    case 800:
      iconImagePath =
          isDayTime ? 'assets/Sun/sun.png' : 'assets/Sunset/moon.png';
      break;
    //clouds
    case 801:
      iconImagePath = isDayTime
          ? 'assets/Clouds/Clear/clouds.png'
          : 'assets/Sunset/clouds.png';
      break;
    case 802:
      iconImagePath = 'assets/Clouds/Clear/broken.png';
      break;
    case 803:
      iconImagePath = 'assets/Clouds/Clear/scattered.png';
      break;
    case 804:
      iconImagePath = 'assets/Clouds/Clear/overcast.png';
      break;
    default:
      iconImagePath = 'assets/Clouds/Clear/clear_day.png';
  }
  return Image.asset(
    iconImagePath,
    height: 160,
    width: iconWidth,
  );
}
