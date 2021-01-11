import 'package:flutter_test/flutter_test.dart';

import 'package:timezone_to_country/timezone_to_country.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() {
  test('translates timezone id to country code', () {
    expect(TimeZoneToCountry.getCountryCode('Asia/Seoul'), 'KR');
    expect(TimeZoneToCountry.getCountryCode('America/Los_Angeles'), 'US');
    expect(TimeZoneToCountry.getCountryCode('Europe/London'), 'GB');

    expect(TimeZoneToCountry.getCountryCode('Wrong/Time_Zone'), null);
    expect(TimeZoneToCountry.getCountryCode('GMT'), null);
    expect(TimeZoneToCountry.getCountryCode('UTC'), null);
    expect(TimeZoneToCountry.getCountryCode(null), null);
  });

  test('gets country code from [Location]', () async {
    tz.initializeTimeZones();

    expect(tz.getLocation('Asia/Seoul').countryCode, 'KR');
    expect(tz.getLocation('America/Los_Angeles').countryCode, 'US');
    expect(tz.getLocation('Europe/London').countryCode, 'GB');

    expect(tz.getLocation('US/Central').countryCode, null);
    expect(tz.getLocation('US/Eastern').countryCode, null);
    expect(tz.getLocation('US/Pacific').countryCode, null);
  });

  test('Unsupported [Location]', () async {
    tz.initializeTimeZones();
    tz.timeZoneDatabase.locations.entries
        .where((location) => location.value.countryCode == null)
        .forEach((location) => print(location.key));
  });
}
