# timezone_to_country

[![pub package](https://badgen.net/pub/v/timezone_to_country)](https://pub.dev/packages/timezone_to_country)
[![pub points](https://badgen.net/pub/points/timezone_to_country)](https://pub.dev/packages/timezone_to_country/score)
[![pub downloads](https://badgen.net/pub/dm/timezone_to_country)](https://pub.dev/packages/timezone_to_country/score)
[![device_info_plus](https://github.com/kyle-seongwoo-jun/flutter_timezone_to_country/actions/workflows/flutter.yml/badge.svg)](https://github.com/kyle-seongwoo-jun/flutter_timezone_to_country/actions/workflows/flutter.yml)

Library for translation Time Zone Id to ISO 3166-1 alpha-2 code (e.g. `'Asia/Seoul'` to `'KR'`)

![example](https://raw.githubusercontent.com/kyle-seongwoo-jun/flutter_timezone_to_country/main/images/example.png)

## Usage

```dart
TimeZoneToCountry.getCountryCode('Asia/Seoul')          // 'KR'
TimeZoneToCountry.getCountryCode('America/Los_Angeles') // 'US'
TimeZoneToCountry.getCountryCode('Europe/London')       // 'GB'
```

```dart
String code = await TimeZoneToCountry.getLocalCountryCode();
print(code);  // 'KR'
```

## Source of Time Zone

IANA - Time Zone Database - [2024b](https://github.com/eggert/tz/blob/2024b/zone.tab)
