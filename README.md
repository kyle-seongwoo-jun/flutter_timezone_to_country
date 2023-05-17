# timezone_to_country

[![pub package](https://img.shields.io/pub/v/timezone_to_country.svg)](https://pub.dev/packages/timezone_to_country)
[![pub points](https://img.shields.io/pub/points/timezone_to_country?color=2E8B57&label=pub%20points)](https://pub.dev/packages/timezone_to_country/score)
[![device_info_plus](https://github.com/kyle-seongwoo-jun/flutter_timezone_to_country/actions/workflows/flutter.yml/badge.svg)](https://github.com/kyle-seongwoo-jun/flutter_timezone_to_country/actions/workflows/flutter.yml)

Library for translation Time Zone Id to ISO 3166-1 alpha-2 code (e.g. 'Asia/Seoul' to 'KR')

![example](https://raw.githubusercontent.com/kyle-seongwoo-jun/flutter_timezone_to_country/master/images/example.png)

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

IANA - Time Zone Database - 2023c (<https://github.com/eggert/tz/blob/2023c/zone.tab>)
