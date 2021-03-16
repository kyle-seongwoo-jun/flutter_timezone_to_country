import 'package:flutter_test/flutter_test.dart';

import 'package:timezone_to_country/timezone_to_country.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() {
  const String NOT_FOUND = 'NOT_FOUND';
  final Matcher throwsCountryNotFoundException = throwsA(isA<CountryNotFoundException>());

  group('TimeZoneToCountry', () {
    test('translates timezone id to country code', () {
      expect(TimeZoneToCountry.getCountryCode('Asia/Seoul'), 'KR');
      expect(TimeZoneToCountry.getCountryCode('America/Los_Angeles'), 'US');
      expect(TimeZoneToCountry.getCountryCode('Europe/London'), 'GB');

      expect(() => TimeZoneToCountry.getCountryCode('Wrong/Time_Zone'), throwsCountryNotFoundException);
      expect(() => TimeZoneToCountry.getCountryCode('GMT'), throwsCountryNotFoundException);
      expect(() => TimeZoneToCountry.getCountryCode('UTC'), throwsCountryNotFoundException);

      expect(TimeZoneToCountry.getCountryCode('Wrong/Time_Zone', onNotFound: () => NOT_FOUND), NOT_FOUND);
      expect(TimeZoneToCountry.getCountryCode('GMT', onNotFound: () => NOT_FOUND), NOT_FOUND);
      expect(TimeZoneToCountry.getCountryCode('UTC', onNotFound: () => NOT_FOUND), NOT_FOUND);
    });

    test('gets country code from [Location]', () async {
      tz.initializeTimeZones();

      expect(tz.getLocation('Asia/Seoul').countryCode, 'KR');
      expect(tz.getLocation('America/Los_Angeles').countryCode, 'US');
      expect(tz.getLocation('Europe/London').countryCode, 'GB');

      expect(() => tz.getLocation('US/Central').countryCode, throwsCountryNotFoundException);
      expect(() => tz.getLocation('US/Eastern').countryCode, throwsCountryNotFoundException);
      expect(() => tz.getLocation('US/Pacific').countryCode, throwsCountryNotFoundException);

      expect(tz.getLocation('US/Central').getCountryCode(onNotFound: () => NOT_FOUND), NOT_FOUND);
      expect(tz.getLocation('US/Eastern').getCountryCode(onNotFound: () => NOT_FOUND), NOT_FOUND);
      expect(tz.getLocation('US/Pacific').getCountryCode(onNotFound: () => NOT_FOUND), NOT_FOUND);
    });
  });

  group('to check', () {
    test('Unsupported [Location]', () async {
      tz.initializeTimeZones();
      tz.timeZoneDatabase.locations.entries
          .where((location) => location.value.getCountryCode(onNotFound: () => NOT_FOUND) == NOT_FOUND)
          .forEach((location) => print(location.key));
    });
  });
}
