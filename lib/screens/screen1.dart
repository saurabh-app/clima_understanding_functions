import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screen1 extends StatefulWidget {
  final dynamic weatherdata;
  const Screen1({super.key, required this.weatherdata});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var apiKey = "f2ba5b65a489fd4cdd5d0a352284a03b";
  String? cityName;
  String? currentWeather;
  String? tempInCel;
  String emoji = '';

  @override
  void initState() {
    super.initState();
    if (widget.weatherdata != null) {
      print(widget.weatherdata['name']);
      updateUI(widget.weatherdata);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/screen1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      print("Near me pressed");
                    },
                    icon: const Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print("Location pressed");
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              Text(
                cityName ?? "Loading...",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${tempInCel ?? "--"}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    currentWeather ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String kelvinToCel(dynamic temp) {
    double tempInCelsius = temp - 273.15;
    return tempInCelsius.toStringAsFixed(2);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) return;

    int weatherId = weatherData['weather'][0]['id'];
    if (weatherId >= 200 && weatherId < 300) {
      emoji = "⛈️";
    } else if (weatherId >= 300 && weatherId < 400) {
      emoji = "🌦️";
    } else if (weatherId >= 500 && weatherId < 600) {
      emoji = "🌧️";
    } else if (weatherId >= 600 && weatherId < 700) {
      emoji = "❄️";
    } else if (weatherId >= 700 && weatherId < 800) {
      emoji = "🌫️";
    } else if (weatherId == 800) {
      emoji = "☀️";
    } else if (weatherId > 800) {
      emoji = "☁️";
    }

    setState(() {
      tempInCel = kelvinToCel(weatherData['main']['temp']);
      currentWeather = weatherData['weather'][0]['main']; 
      cityName = weatherData['name'];
    });
  }
}
