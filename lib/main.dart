import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weathernow/bloc/weather_bloc_bloc.dart';
import 'package:weathernow/views/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that WidgetsBinding is initialized.

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Locks the app in the portrait orientation.
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return BlocProvider<WeatherBlocBloc>(
              create: (context) =>
                  WeatherBlocBloc()..add(FetchWeather(snapshot.data!)),
              child: const HomeScreen(),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Lottie.asset('assets/images/loading.json'),
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
