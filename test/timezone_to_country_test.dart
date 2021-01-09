import 'package:flutter_test/flutter_test.dart';

import 'package:timezone_to_country/timezone_to_country.dart';

void main() {
  test('translates timezone id to country code', () {
    expect(TimeZoneToCountry.getCountryCode('Asia/Seoul'), 'KR');
    expect(TimeZoneToCountry.getCountryCode('America/Los_Angeles'), 'US');
    expect(TimeZoneToCountry.getCountryCode('Europe/London'), 'GB');
    expect(TimeZoneToCountry.getCountryCode('Wrong/Time_Zone'), null);
    expect(TimeZoneToCountry.getCountryCode(null), null);
  });
}
