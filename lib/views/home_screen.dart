// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weathernow/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Lottie.asset('assets/images/thunderstorm.json');
      case >= 300 && < 400:
        return Lottie.asset('assets/images/drizzle.json');
      case >= 500 && < 600:
        return Lottie.asset('assets/images/rain.json');
      case >= 600 && < 700:
        return Lottie.asset('assets/images/snow.json');
      case >= 700 && < 800:
        return Lottie.asset('assets/images/wind.json');
      case == 800:
        return Lottie.asset('assets/images/clear.json');
      case > 800 && <= 804:
        return Lottie.asset('assets/images/clouds.json');
      default:
        return Lottie.asset('assets/images/clouds.json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            40, kToolbarHeight, 40, 20 + MediaQuery.of(context).padding.bottom),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                kToolbarHeight -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(color: Color(0xff65C7F7)),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 1.2),
                  child: Container(
                    height: 400,
                    width: 600,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff9CECFB)),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 400,
                    width: 600,
                    decoration: BoxDecoration(color: Color(0xff0052D4)),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                ),
                SingleChildScrollView(
                  child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                              ),
                              // Lottie.asset('assets/images/drizzle.json'),
                              getWeatherIcon(
                                  state.weather.weatherConditionCode!),
                              // Image.asset('assets/images/7.png'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/loc.png',
                                    scale: 45,
                                  ),
                                  Text(
                                    ' ${state.weather.areaName}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 28),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Text(
                                  '${state.weather.temperature!.celsius!.round()}°C',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 46,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weather.weatherMain!.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Center(
                                child: Text(
                                  DateFormat('EEEE dd • ')
                                      .add_jm()
                                      .format(state.weather.date!),
                                  // 'Friday 16 • 9:18 pm',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/11.png',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Sunrise',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunrise!),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/12.png',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Sunset',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunset!),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/13.png',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Temp max',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "${state.weather.tempMax!.celsius!.round()} °C",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/14.png',
                                        scale: 8,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Temp min',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "${state.weather.tempMin!.celsius!.round()} °C",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/9.png',
                                        scale: 8,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Wind Speed',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "${state.weather.windSpeed!.round()} km/h",
                                            // "${state.weather.tempMax!.celsius!.round()} °C",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/direction.png',
                                        scale: 8,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            ' Direction ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            "${state.weather.windDegree!.round()}°",
                                            // "${state.weather.tempMin!.celsius!.round()} °C",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
