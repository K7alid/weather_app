import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/dio_helper.dart';
import 'package:weather_app/layout/cubit/states.dart';
import 'package:weather_app/weather_data_model.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit() : super(WeatherInitialState());
  static WeatherCubit get(context) => BlocProvider.of(context);
  WeatherData? weatherData;

  void getWeather(String value) {
    emit(WeatherGetDataLoadingState());
    DioHelper.getData(
      url: 'data/2.5/weather',
      query: {
        'units': 'metric',
        'q': value,
        'appid': 'd7d896796e73397c1be73b9398571659',
      },
    ).then((value) {
      weatherData = WeatherData.fromJson(value.data);
      emit(WeatherGetDataSuccessState());
    }).catchError((error) {
      emit(WeatherGetDataErrorState(error.toString()));
    });
  }

  void getWeatherByLonAndLat({
    required double lon,
    required double lat,
  }) {
    emit(WeatherGetDataLoadingState());
    DioHelper.getData(
      url: 'data/2.5/weather',
      query: {
        'units': 'metric',
        'lon': lon,
        'lat': lat,
        'appid': 'd7d896796e73397c1be73b9398571659',
      },
    ).then((value) {
      weatherData = WeatherData.fromJson(value.data);
      emit(WeatherGetDataSuccessState());
    }).catchError((error) {
      emit(WeatherGetDataErrorState(error.toString()));
    });
  }

  LocationPermission? permission;
  void getLocation() async {
    permission = await Geolocator.requestPermission();
    emit(GetLocationState());
  }
}
