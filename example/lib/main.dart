import 'package:flutter/material.dart';
import 'package:timezone_to_country/timezone_to_country.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Local country code app'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: TimeZoneToCountry.getLocalCountryCode(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return const Text('Could not get the local country code');
              }

              String countryCode = snapshot.data!;
              return Text(
                'Local country code: ${countryCode} ${EmojiUtils.country(countryCode)}',
                style: Theme.of(context).textTheme.headlineSmall,
              );
            },
          ),
        ),
      ),
    );
  }
}

class EmojiUtils {
  static String country(String countryCode) {
    String flag = countryCode.replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }
}
