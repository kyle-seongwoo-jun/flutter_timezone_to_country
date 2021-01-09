import 'package:flutter_test/flutter_test.dart';

import 'package:timezone_to_country/timezone_to_country.dart';

void main() {
  test('translates timezone id to country code', () {
    expect(TimeZoneToCountry.countryCode('Asia/Seoul'), 'KR');
    expect(TimeZoneToCountry.countryCode('America/Los_Angeles'), 'US');
    expect(TimeZoneToCountry.countryCode('Europe/London'), 'GB');
    expect(TimeZoneToCountry.countryCode('Wrong/Time_Zone'), null);
    expect(TimeZoneToCountry.countryCode(null), null);
  });
}
