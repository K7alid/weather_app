abstract class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherGetDataLoadingState extends WeatherStates {}

class WeatherGetDataSuccessState extends WeatherStates {}

class WeatherGetDataErrorState extends WeatherStates {
  final String error;
  WeatherGetDataErrorState(this.error);
}

class ChangeCityNameState extends WeatherStates {}

class GetLocationState extends WeatherStates {}
