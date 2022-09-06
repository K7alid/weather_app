import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class WeatherLayout extends StatelessWidget {
  WeatherLayout({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = WeatherCubit.get(context);
        MaterialColor defaultColor = Colors.grey;
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Image.network(
                  'https://c4.wallpaperflare.com/wallpaper/744/330/459/nature-sunset-night-sky-shooting-stars-wallpaper-preview.jpg',
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: defaultTextFormField(
                                  onSubmitted: () {
                                    cubit.getWeather(searchController.text);
                                  },
                                  prefixIconColor: defaultColor,
                                  labelColor: defaultColor,
                                  radius: 20,
                                  textColor: defaultColor,
                                  borderColor: defaultColor,
                                  label: 'City Name',
                                  prefix: Icons.search,
                                  textInputType: TextInputType.text,
                                  controller: searchController,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter city to search';
                                    }
                                  },
                                ),
                              ),
                              spaceInWidth(width: 15),
                              Container(
                                height: 58,
                                decoration: const BoxDecoration(
                                    color: Colors.grey, shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () async {
                                    cubit.getLocation();
                                    Position position =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.high);
                                    cubit.getWeatherByLonAndLat(
                                        lon: position.longitude,
                                        lat: position.latitude);
                                  },
                                  icon: const Icon(
                                    Icons.my_location,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          spaceInHeight(height: 30),
                          Text(
                            '${cubit.weatherData?.name ?? 'CityName'}, ${cubit.weatherData?.sys.country ?? 'CountryCode'}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          spaceInHeight(height: 30),
                          Text(
                            '${cubit.weatherData?.main.temp ?? 0}\u00B0C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 70),
                          ),
                          spaceInHeight(height: 30),
                          Image.network(
                            'http://openweathermap.org/img/wn/${cubit.weatherData?.weather[0].icon ?? '04n'}@2x.png',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                          spaceInHeight(height: 30),
                          Text(
                            cubit.weatherData?.weather[0].description ??
                                'Description',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
