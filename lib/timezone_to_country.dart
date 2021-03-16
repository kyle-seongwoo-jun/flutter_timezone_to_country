library timezone_to_country;

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart';

part 'timezone_to_country.g.dart';

class TimeZoneToCountry {
  static String getCountryCode(String timezoneId, {String Function()? onNotFound}) {
    final code = _lookup(timezoneId);
    if (code != null) return code;

    // on not found
    if (onNotFound != null) return onNotFound();
    throw CountryNotFoundException(timezoneId);
  }

  static Future<String> getLocalCountryCode({String Function()? onNotFound}) async {
    final local = await FlutterNativeTimezone.getLocalTimezone();
    return getCountryCode(local, onNotFound: onNotFound);
  }
}

extension CountryCodeExtension on Location {
  String get countryCode => TimeZoneToCountry.getCountryCode(this.name);

  String getCountryCode({String Function()? onNotFound}) =>
      TimeZoneToCountry.getCountryCode(this.name, onNotFound: onNotFound);
}

class CountryNotFoundException implements Exception {
  final String timezoneId;

  CountryNotFoundException(this.timezoneId);

  @override
  String toString() => 'CountryNotFoundException: timezoneId: $timezoneId';
}
