part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class WeatherBlocLoading extends WeatherBlocState {}

final class WeatherBlocFailure extends WeatherBlocState {}

final class WeatherBlocSuccess extends WeatherBlocState {
  final weatherc.Weather curentWeather;
  final ForecastWeatherModel forecastWeather;
  final ReverseGeoGeocodingModel reverseGeoModel;

  const WeatherBlocSuccess(
      {required this.curentWeather,
      required this.reverseGeoModel,
      required this.forecastWeather});
  @override
  List<Object> get props => [curentWeather];
}
