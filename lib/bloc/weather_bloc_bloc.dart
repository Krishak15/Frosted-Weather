import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart' as weatherc;
import 'package:weatherapp_frosted/api/endpoints.dart';
import 'package:weatherapp_frosted/private/api_key.dart';
import 'package:http/http.dart' as http;

import '../model/forecast_weather_model.dart';
import '../model/reverse_geocoding_model.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        weatherc.WeatherFactory wf = weatherc.WeatherFactory(apiKey,
            language: weatherc.Language.ENGLISH);
        ReverseGeoGeocodingModel reverseGeoModel;
        ForecastWeatherModel forecastWeather;

        //Weather API call
        weatherc.Weather currentWeather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);

        //Forecast
        final responseForecast = await http.get(Uri.parse(
            "${forecastBaseUrl}lat=${event.position.latitude.toStringAsFixed(6)}&lon=${event.position.longitude.toStringAsFixed(6)}&appid=$apiKey&units=metric"));

        //RevGeo API Call
        final coordinatesval =
            'lat=${event.position.latitude.toStringAsFixed(6)}&lon=${event.position.longitude.toStringAsFixed(6)}';

        final response = await http.get(Uri.parse(
            "${reverseGeoCodingBaseUrl}key=$apiKeyGeoCoding&$coordinatesval&format=json"));

        if (responseForecast.statusCode == 200 && response.statusCode == 200) {
          print("${responseForecast.statusCode}  ${response.statusCode}");

          forecastWeather =
              ForecastWeatherModel.fromJson(json.decode(responseForecast.body));

          print(forecastWeather.city.name);

          reverseGeoModel =
              ReverseGeoGeocodingModel.fromJson(json.decode(response.body));
          print(reverseGeoModel.displayName);

          emit(WeatherBlocSuccess(
              curentWeather: currentWeather,
              reverseGeoModel: reverseGeoModel,
              forecastWeather: forecastWeather));
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });

    //REFRESH: current weather refresh
    on<RefreshWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        weatherc.WeatherFactory wf = weatherc.WeatherFactory(apiKey,
            language: weatherc.Language.ENGLISH);
        ReverseGeoGeocodingModel reverseGeoModel;

        // Weather API call
        weatherc.Weather weather = await wf.currentWeatherByLocation(
          position.latitude,
          position.longitude,
        );

        if (kDebugMode) {
          print(weather);
        }

        // List<weatherc.Weather> forecastWeather = await wf
        //     .fiveDayForecastByLocation(position.latitude, position.longitude);

        ForecastWeatherModel? forecastWeather;
        //Forecast

        final responseForecast = await http.get(Uri.parse(
            "${forecastBaseUrl}lat=${position.latitude.toStringAsFixed(6)}&lon=${position.longitude.toStringAsFixed(6)}&appid=$apiKey&units=metric"));
        if (responseForecast.statusCode == 200) {
          if (kDebugMode) {
            print(responseForecast.statusCode);
          }
          forecastWeather =
              ForecastWeatherModel.fromJson(json.decode(responseForecast.body));
        }

        // Reverse Geocoding API call
        final coordinatesval =
            'lat=${position.latitude.toStringAsFixed(6)}&lon=${position.longitude.toStringAsFixed(6)}';

        final response = await http.get(Uri.parse(
            "${reverseGeoCodingBaseUrl}key=$apiKeyGeoCoding&$coordinatesval&format=json"));

        if (response.statusCode == 200) {
          reverseGeoModel =
              ReverseGeoGeocodingModel.fromJson(json.decode(response.body));
        } else {
          throw Exception('Failed to load data');
        }
        emit(WeatherBlocSuccess(
            curentWeather: weather,
            reverseGeoModel: reverseGeoModel,
            forecastWeather: forecastWeather!));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
