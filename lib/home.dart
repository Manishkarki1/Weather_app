import 'dart:convert';
import 'package:mappinglist/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mappinglist/api.dart';
import 'package:mappinglist/forecast.dart';
import 'additional.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double temp = 0;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Nepal';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );
      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          Tooltip(
              message: 'Refresh',
              child: IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh),
              )),
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const CircularProgressIndicator.adaptive());
            }
            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
              );
            }

            final data = snapshot.data!;

            final currentData = data['list'][0];
            final currentTemp = currentData['main']['temp'];
            final currentSky = currentData['weather'][0]['main'];
            final currentPressure = currentData['main']['pressure'];
            final currentWind = currentData['wind']['speed'];
            final currentHumidity = currentData['main']['humidity'];

            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
              child: ListView(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 55,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                '$currentSky',
                                style: TextStyle(fontSize: 18),
                              ),
                              CurrentTime(),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Hourly forecast',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       Weather(
                  //           icon1: Icons.cloud,
                  //           time: '00:00',
                  //           temperature: '301.22'),
                  //       Weather(
                  //           icon1: Icons.sunny,
                  //           time: '00:00',
                  //           temperature: '300.52'),
                  //       Weather(
                  //           icon1: Icons.cloud,
                  //           time: '00:00',
                  //           temperature: '302.22'),
                  //       Weather(
                  //           icon1: Icons.sunny,
                  //           time: '00:00',
                  //           temperature: '300.22'),
                  //       Weather(
                  //           icon1: Icons.cloud,
                  //           time: '00:00',
                  //           temperature: '301.22'),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int i) {
                        final hourlyForecast = data['list'][i + 1];
                        final time = DateTime.parse(hourlyForecast['dt_txt']);
                        return Weather(
                            icon1: data['list'][i + 1]['weather'][0]['main'] ==
                                        'Clouds' ||
                                    data['list'][i + 1]['weather'][0]['main'] ==
                                        'Rain'
                                ? Icons.cloud
                                : Icons.sunny,
                            time: DateFormat.jm().format(time),
                            temperature:
                                hourlyForecast['main']['temp'].toString());
                      },
                      itemCount: 5,
                    ),
                  ),

                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Additional(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        detail: currentHumidity.toString(),
                      ),
                      Additional(
                          icon: Icons.air_outlined,
                          label: 'Wind Speed',
                          detail: currentWind.toString()),
                      Additional(
                          icon: Icons.cloud_upload,
                          label: 'Pressure',
                          detail: currentPressure.toString()),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
