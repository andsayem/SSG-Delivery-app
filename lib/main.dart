import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';

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
      home: const MyHomePage(title: 'Sales Automation'),
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
  void initState() {
    super.initState();
    _launchURL('https://ssforce.ssgbd.com/otp-check');
  }

  _launchURL(base_url) async {
    final Uri url = Uri.parse(base_url);
    if (!await await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch  ');
    }
  }

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            HexColor("#d257aa"), // navigation bar color
        statusBarColor:
            Theme.of(context).colorScheme.background, // status bar color
        statusBarIconBrightness: Brightness.light, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.light, //navigation bar icons' color
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#d257aa"),
        centerTitle: true,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => _launchURL('https://ssforce.ssgbd.com/otp-check'),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                    ),
                  ),
                  Icon( 
                      Icons.arrow_forward_ios , color:HexColor("#d257aa") ,
                  )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
