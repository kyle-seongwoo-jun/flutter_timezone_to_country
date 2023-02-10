/// Library for translation Time Zone Id to ISO 3166-1 alpha-2 code (e.g. 'Asia/Seoul' to 'KR')
library timezone_to_country;

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart';

part 'timezone_to_country.g.dart';
part 'timezone_to_country.manual.g.dart';

String? _lookup(String timezoneId) => _map[timezoneId] ?? _map2[timezoneId];

class TimeZoneToCountry {
  /// Gets country code from TimezoneId.
  ///
  /// Throws an [CountryNotFoundException] if the country code could not found and [onNotFound] is `null`.
  static String getCountryCode(
    String timezoneId, {
    String Function()? onNotFound,
  }) {
    final code = _lookup(timezoneId);
    if (code != null) return code;

    // on not found
    if (onNotFound != null) return onNotFound();
    throw CountryNotFoundException(timezoneId);
  }

  /// Gets country code from TimezoneId.
  ///
  /// Returns `null` if the country code could not found.
  static String? getCountryCodeOrNull(String timezoneId) {
    return _lookup(timezoneId);
  }

  /// Get county code from local timezone.
  ///
  /// Throws an [CountryNotFoundException] if the country code could not found and [onNotFound] is `null`.
  static Future<String> getLocalCountryCode({
    String Function()? onNotFound,
  }) async {
    final local = await FlutterTimezone.getLocalTimezone();
    return getCountryCode(local, onNotFound: onNotFound);
  }

  /// Get county code from local timezone.
  ///
  /// Returns `null` if the country code could not found.
  static Future<String?> getLocalCountryCodeOrNull() async {
    final local = await FlutterTimezone.getLocalTimezone();
    return getCountryCodeOrNull(local);
  }
}

extension CountryCodeExtension on Location {
  /// Gets country code from [Location.name].
  ///
  /// Throws an [CountryNotFoundException] if the country code could not found.
  String get countryCode => TimeZoneToCountry.getCountryCode(this.name);

  /// Gets country code from [Location.name].
  ///
  /// Returns `null` if the country code could not found.
  String? get countryCodeOrNull =>
      TimeZoneToCountry.getCountryCodeOrNull(this.name);

  /// Gets country code from [Location.name].
  ///
  /// Throws an [CountryNotFoundException] if the country code could not found and [onNotFound] is `null`.
  String getCountryCode({String Function()? onNotFound}) =>
      TimeZoneToCountry.getCountryCode(this.name, onNotFound: onNotFound);
}

class CountryNotFoundException implements Exception {
  final String timezoneId;

  CountryNotFoundException(this.timezoneId);

  @override
  String toString() => 'CountryNotFoundException: timezoneId: $timezoneId';
}
