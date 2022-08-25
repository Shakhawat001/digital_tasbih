import 'dart:ui';
import 'dart:io' show platform;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black87,
        primarySwatch: Colors.teal,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.black87,
            // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            textStyle: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.teal,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            // padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            textStyle: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Digital Tasbih'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<bool> isSelected = [true, false];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void counterReset() {
    setState(() {
      _counter = 0;
    });
  }

  AdRequest? adRequest;
  BannerAd? bannerAdd;

  @override
  void initState() {
    super.initState();

    String bannerID = "ca-app-pub-3940256099942544/6300978111";

    adRequest = const AdRequest(
      nonPersonalizedAds: false,
    );

    BannerAdListener bannerAdListener = BannerAdListener(onAdClosed: (ad) {
      bannerAdd!.load();
    }, onAdFailedToLoad: (ad, err) {
      bannerAdd!.load();
    });

    bannerAdd = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerID,
        listener: bannerAdListener,
        request: adRequest!);

    bannerAdd!.load();
  }

  @override
  void dispose() {
    bannerAdd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Tasbih"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AdWidget(
                  ad: bannerAdd!,
                ),
                ElevatedButton.icon(
                  onPressed: counterReset,
                  label: Text("Reset"),
                  icon: Icon(Icons.restart_alt_rounded),
                ),
              ],
            ),
            Text(
              '$_counter',
              style: TextStyle(color: Colors.teal, fontSize: 72),
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Icon(Icons.add),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
