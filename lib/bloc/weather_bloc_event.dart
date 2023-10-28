part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final Position position;

  const FetchWeather({required this.position});
  @override
  List<Object> get props => [position];
}

class RefreshWeather extends WeatherBlocEvent {
  const RefreshWeather();

  @override
  List<Object> get props => [];
}


// class FetchRevGeo extends WeatherBlocEvent {
//    final Position position;

//    const FetchRevGeo({required this.position});

//    @override
//   List<Object> get props => [position];
// }
