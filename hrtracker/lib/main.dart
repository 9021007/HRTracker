import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

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
  @override
  Widget build(BuildContext context) {
    const startms = 1686349500000;
    const user = 'Example User';
    const dosemg = 4; //amount per dose
    const doseinterval = 7; //days between doses
    const form = 'injection'; //injection, patch, pill, gel, spray, pellet
    const unitsperdose = 1; //how many units per dose, eg 1 vial, 1 patch, 1 pill, 1 pump, 1 spray, 1 pellet

    var hrtstartdate = DateTime.fromMillisecondsSinceEpoch(startms);
    var difference = DateTime.now().difference(hrtstartdate);
    var differencehours = 0;
    var differencemins = 0;
    var differenceseconds = 0;
    var secondtext = 'seconds';

    var totaldoses = (difference.inDays / doseinterval).ceil(); //total times taken
    var totalhrt = totaldoses * dosemg * unitsperdose; //total mg taken
    var totalunits = totalhrt / dosemg; //total shots/pills/patches/etc taken

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
            const Text(
              '$user has been on HRT for',
            ),
            Text(
              '$timertext',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            Text(
              'and has taken $totalunits $form for a total of $totalhrt mg.',
            ),
          ],
        ),
      ),
    );
  }
}
