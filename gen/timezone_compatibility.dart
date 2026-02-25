import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Find timezones that exist in `timezone` package but not in the tz database,
/// and return their guessed country codes
Map<String, String> findUnmappedTimezonesWithCountryCodes(
  Map<String, String> timezones,
) {
  tz.initializeTimeZones();

  final unmapped = Map.fromEntries(() sync* {
    // iterate through timezones that exist in timezone package but not in the tz database
    for (final timezoneId in tz.timeZoneDatabase.locations.keys
        .where((timezoneId) => timezones[timezoneId] == null)) {
      // manually guess the country code for those timezones
      final code = _guessCountryCodeFrom(timezoneId);
      if (code != null) yield MapEntry(timezoneId, code);
    }
  }());

  return unmapped;
}

String? _guessCountryCodeFrom(String timezoneId) {
  if (timezoneId == 'GMT' ||
      timezoneId == 'UTC' ||
      timezoneId == 'Factory' ||
      timezoneId.startsWith('Etc/'))
    return null;
  if (timezoneId.startsWith('US/')) return 'US';
  if (timezoneId.startsWith('Canada/')) return 'CA';
  if (timezoneId.startsWith('Australia/')) return 'AU';

  final code = {
    'America/Godthab': 'GL',
    'America/Montreal': 'CA',
    'America/Nipigon': 'CA',
    'America/Pangnirtung': 'CA',
    'America/Rainy_River': 'CA',
    'America/Santa_Isabel': 'MX',
    'America/Thunder_Bay': 'CA',
    'America/Yellowknife': 'CA',
    'Asia/Choibalsan': 'MN',
    'Asia/Rangoon': 'MM',
    'Europe/Uzhgorod': 'UA',
    'Europe/Zaporozhye': 'UA',
    'Pacific/Enderbury': 'KI',
    'Pacific/Johnston': 'US',
  }[timezoneId];

  if (code == null) _warn('You should implement: $timezoneId.');
  return code;
}

void _warn(String message) => print('\x1B[33m$message\x1B[0m');
