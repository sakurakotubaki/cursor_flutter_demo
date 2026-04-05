import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets/weather_background.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Weather _weather = Weather.sunny;

  void _toggleWeather() {
    print('toggleWeather');
    setState(() {
      _weather =
          _weather == Weather.sunny ? Weather.rainy : Weather.sunny;
    });
  }

  String get _lottieAsset => _weather == Weather.sunny
      ? 'assets/json/running.json'
      : 'assets/json/pushup.json';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          _weather == Weather.sunny ? 'Sunny Day' : 'Rainy Day',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _weather == Weather.sunny ? Icons.wb_sunny : Icons.grain,
            ),
            onPressed: _toggleWeather,
            tooltip: 'Toggle weather',
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          WeatherBackground(weather: _weather),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Lottie.asset(
                _lottieAsset,
                key: ValueKey(_weather),
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
