import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone_to_country/timezone_to_country.dart';

void main() {
  const String NOT_FOUND = 'NOT_FOUND';
  const String WRONG_TIMEZONE = 'Wrong/Time_Zone';
  final Matcher throwsCountryNotFoundException =
      throwsA(isA<CountryNotFoundException>());

  group('TimeZoneToCountry', () {
    test('translates timezone id to country code', () {
      expect(TimeZoneToCountry.getCountryCode('Asia/Seoul'), 'KR');
      expect(TimeZoneToCountry.getCountryCode('America/Los_Angeles'), 'US');
      expect(TimeZoneToCountry.getCountryCode('Europe/London'), 'GB');

      expect(() => TimeZoneToCountry.getCountryCode(WRONG_TIMEZONE),
          throwsCountryNotFoundException);
      expect(() => TimeZoneToCountry.getCountryCode('GMT'),
          throwsCountryNotFoundException);
      expect(() => TimeZoneToCountry.getCountryCode('UTC'),
          throwsCountryNotFoundException);

      expect(
          TimeZoneToCountry.getCountryCode(WRONG_TIMEZONE,
              onNotFound: () => NOT_FOUND),
          NOT_FOUND);
      expect(
          TimeZoneToCountry.getCountryCode('GMT', onNotFound: () => NOT_FOUND),
          NOT_FOUND);
      expect(
          TimeZoneToCountry.getCountryCode('UTC', onNotFound: () => NOT_FOUND),
          NOT_FOUND);

      expect(TimeZoneToCountry.getCountryCodeOrNull(WRONG_TIMEZONE), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('GMT'), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('UTC'), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('Etc/GMT'), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('Etc/GMT+9'), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('Etc/GMT-10'), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('Etc/UTC'), null);
      expect(TimeZoneToCountry.getCountryCodeOrNull('Factory'), null);
    });

    test('gets country code from [Location]', () async {
      tz.initializeTimeZones();

      expect(tz.getLocation('Asia/Seoul').countryCode, 'KR');
      expect(tz.getLocation('America/Los_Angeles').countryCode, 'US');
      expect(tz.getLocation('Europe/London').countryCode, 'GB');
    });
  });

  group('to check', () {
    test('Unsupported [Location]', () async {
      tz.initializeTimeZones();
      final unsupported = tz.timeZoneDatabase.locations.values
          .where(
            (location) =>
                location.name != 'GMT' &&
                location.name != 'UTC' &&
                location.name != 'Factory' &&
                !location.name.startsWith('Etc/'),
          )
          .where((location) => location.countryCodeOrNull == null) // not found
          .toList();
      expect(unsupported, isEmpty);
    });

    test('translates country code to emoji', () {
      String countryCode = 'KR';
      String flag = countryCode.replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
      expect(flag, '🇰🇷');
    });
  });
}
