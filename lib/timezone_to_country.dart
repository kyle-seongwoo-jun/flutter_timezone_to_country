library timezone_to_country;

import 'package:flutter_native_timezone/flutter_native_timezone.dart';

part 'timezone_to_country.g.dart';

class TimeZoneToCountry {
  static String getCountryCode(String timezoneId) => _lookup(timezoneId);

  static Future<String> getLocalCountryCode() async {
    final local = await FlutterNativeTimezone.getLocalTimezone();
    return getCountryCode(local);
  }
}
