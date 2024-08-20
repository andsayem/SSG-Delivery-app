import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery app',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    // ConnectivityResult result;
    // try {
    //   result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    // } catch (e) {
    //   result = ConnectivityResult.none;
    // }

    // if (result != ConnectivityResult.none) {
    //   final bool hasInternet = await _checkInternetAccess();
    //   if (hasInternet) {
      //  _connectionStatus = 'Connected to Internet';
        _launchURL('https://ssforce.ssgbd.com/otp-check');
    //   } else {
    //     _connectionStatus = 'No Internet Access';
    //     _showNoConnectionDialog();
    //   }
    // } else {
    //   setState(() {
    //     _connectionStatus = 'No Internet Connection';
    //     _showNoConnectionDialog();
    //   });
    // }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  _launchURL(String baseUrl) async {
    final Uri url = Uri.parse(baseUrl);
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch URL');
    }
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please check your internet connection and try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: HexColor("#d257aa"), // navigation bar color
        statusBarColor: Theme.of(context).colorScheme.background, // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light, // navigation bar icons' color
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#d257aa"),
        centerTitle: true,
        title: Text(
          'Sales Automation',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => _checkConnectivity(),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 100,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: HexColor("#d257aa"),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            // Text(
            //   'Connection Status: $_connectionStatus',
            //   style: TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }
}