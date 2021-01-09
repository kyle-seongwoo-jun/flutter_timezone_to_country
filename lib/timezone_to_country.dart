library timezone_to_country;

part 'timezone_to_country.g.dart';

class TimeZoneToCountry {
  static String countryCode(String timezoneId) => _lookup(timezoneId);
}
