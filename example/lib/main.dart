import 'package:flutter/material.dart';
import 'package:timezone_to_country/timezone_to_country.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _countryCode = 'Unknown';

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      _countryCode = await TimeZoneToCountry.getLocalCountryCode();
    } catch (e) {
      print('Could not get the local country code');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Local country code app'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Local country code: $_countryCode',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          )),
    );
  }
}
