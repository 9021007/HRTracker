import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/info.json'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int startms;
  final String user;
  final int dosemg;
  final int doseinterval;
  final String form;
  final int unitsperdose;

  const Album({
    required this.startms,
    required this.user,
    required this.dosemg,
    required this.doseinterval,
    required this.form,
    required this.unitsperdose,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      startms: json['startms'],
      user: json['user'],
      dosemg: json['dosemg'],
      doseinterval: json['doseinterval'],
      form: json['form'],
      unitsperdose: json['unitsperdose'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HRTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'HRTracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    

    Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite),
              SizedBox(width: 10),
              Text('HRTracker'),
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Center(
              child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var startms = snapshot.data!.startms;
                    var user = snapshot.data!.user;
                    var dosemg = snapshot.data!.dosemg; //amount per dose
                    var doseinterval =
                        snapshot.data!.doseinterval; //days between doses
                    var form = snapshot.data!
                        .form; //injection, patch, pill, gel, spray, pellet
                    var unitsperdose = snapshot.data!
                        .unitsperdose; //how many units per dose, eg 1 vial, 1 patch, 1 pill, 1 pump, 1 spray, 1 pellet

                    var hrtstartdate =
                        DateTime.fromMillisecondsSinceEpoch(startms);
                    var difference = DateTime.now().difference(hrtstartdate);
                    var differencehours = 0;
                    var differencemins = 0;
                    var differenceseconds = 0;
                    var secondtext = 'seconds';

                    var totaldoses = (difference.inDays / doseinterval)
                        .ceil(); //total times taken
                    var totalhrt =
                        totaldoses * dosemg * unitsperdose; //total mg taken
                    var totalunits =
                        totalhrt / dosemg; //total shots/pills/patches/etc taken

                    double width = MediaQuery.of(context).size.width;
                    double height = MediaQuery.of(context).size.height;
                    var landscape = false;

                    if (width > height) {
                      landscape = true;
                    }

                    if (difference.inHours < 24) {
                      differencehours = difference.inHours;
                    } else {
                      differencehours = difference.inHours % 24;
                    }

                    if (difference.inMinutes < 60) {
                      differencemins = difference.inMinutes;
                    } else {
                      differencemins = difference.inMinutes % 60;
                    }

                    if (difference.inSeconds < 60) {
                      differenceseconds = difference.inSeconds;
                    } else {
                      differenceseconds = difference.inSeconds % 60;
                    }

                    if (differenceseconds == 1) {
                      secondtext = 'second';
                    }

                    var landscapetext =
                        '${difference.inDays} days, $differencehours hours, $differencemins minutes, and $differenceseconds $secondtext.';
                    var portraittext =
                        '${difference.inDays} days,\n $differencehours hours,\n $differencemins minutes,\n and $differenceseconds $secondtext.';
                    var timertext = portraittext;

                    if (landscape) {
                      timertext = landscapetext;
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Spacer(),
                        Text(
                          '$user has been on HRT for',
                        ),
                        Text(
                          '$timertext',
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'and has taken $totalunits $form for a total of $totalhrt mg.',
                        ),
                        // Spacer(),
                        
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
            Spacer(),
            InkWell(
              child: const Text(
                  "Made with ❤️ by @9021007, written in Flutter"),
              onTap: () => launchUrl(
                  Uri.parse("https://links.9021007.xyz/"))),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
