# timezone_to_country

[![pub package](https://img.shields.io/pub/v/timezone_to_country.svg)](https://pub.dev/packages/timezone_to_country)

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
IANA - Time Zone Database - 2021a (https://github.com/eggert/tz/blob/2021a/zone.tab)

## Unsupported Time Zones on [timezone package](https://pub.dev/packages/timezone)
```
America/Godthab
America/Montreal
America/Santa_Isabel
Asia/Rangoon
Australia/Currie
Canada/Atlantic
Canada/Central
Canada/Eastern
Canada/Mountain
Canada/Newfoundland
Canada/Pacific
Pacific/Johnston
US/Alaska
US/Arizona
US/Central
US/Eastern
US/Hawaii
US/Mountain
US/Pacific
```
