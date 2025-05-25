import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screen1 extends StatefulWidget {
  final weatherdata;
  const Screen1({super.key, this.weatherdata});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
    var apiKey = "f2ba5b65a489fd4cdd5d0a352284a03b";
    var cityName;
    var currentWeather;
    var tempInCel;
    var emoji = '';

@override
void initState() {
  print(widget.weatherdata['name']);

UpdateUI(widget.weatherdata);
  super.initState();


  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/screen1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(child: Column(
          children: [

             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      print("Pressed");
                    },
                    icon: const Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                    onPressed: () {
                      print("Pressed");
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
               const Text(
                "San Fansisco",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "17°C",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network("https://cdn.iconscout.com/icon/free/png-512/free-cloudy-icon-download-in-svg-png-gif-file-formats--weather-clouds-forecast-cloud-pack-nature-icons-2451828.png?f=webp&w=512", width: 100, height: 100),
                  Text(
                    "Cloudy ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ]
        )
        ),
      ),
    );
  }

  String kelvinToCel(var temp){

    var tempInCel=temp -273.15;
    String tempInString =tempInCel.toStringAsFixed(2);
    return tempInString;
  }

  void getWeatherDataFromCityName(String cityName) async{
    var cityWeatherAPI = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid={API key}";

    var url = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
      'q': cityName,
      'appid': apiKey,
    });
    print(url);

    var response = await http.get(url);

      var data = response.body;
      var weatherData = jsonDecode(data);
      print(weatherData);
  }

  void UpdateUI(weatherData){
    var weatherid=weatherData['weather'][0]['id'];
    if (weatherid >= 200 && weatherid < 300) {
      setState(() {
        emoji = "⛈️";
      });
    } else if (weatherid >= 300 && weatherid < 400) {
      setState(() {
        emoji = "🌦️";
      });
    } else if (weatherid >= 500 && weatherid < 600) {
      setState(() {
        emoji = "🌧️";
      });
    } else if (weatherid >= 600 && weatherid < 700) {
      setState(() {
        emoji = "❄️";
      });
    }else if (weatherid >= 700 && weatherid < 800) {
      setState(() {
        emoji = "❄️";
      });}
      else if (weatherid >= 800) {
      setState(() {
        emoji = "❄️";
      });
    }
    setState(() {
     var temp = weatherData['main']['temp'];
     tempInCel=kelvinToCel(temp);
     currentWeather=weatherData['weather'][0]['name'];
     cityName=weatherData['name'];
     });
      
  }
}
