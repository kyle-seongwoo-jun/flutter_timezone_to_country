import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String _version = '2022c';

void main() async {
  final timezones = await loadTimezones(_version);
  if (timezones.isEmpty) return;

  generateSourceFile('timezone_to_country.g.dart', '_map', timezones);

  final unsupported = unsupportedTimezones(timezones);
  if (timezones.isEmpty) return;

  generateSourceFile('timezone_to_country.manual.g.dart', '_map2', unsupported);
}

/// load timezones and parse
Future<Map<String, String>> loadTimezones(String version) async {
  /// download the timezone file
  final url = Uri.parse(
      'https://raw.githubusercontent.com/eggert/tz/$version/zone.tab');
  final response = await http.get(url);
  if (response.statusCode != 200) {
    print('Request failed with status: ${response.statusCode}.');
    return {};
  }

  // parse timezone
  final lines = response.body.split('\n');
  final map = Map.fromEntries(lines
      .where((line) => !line.startsWith('#') && line.isNotEmpty)
      .map((line) => line.split('\t'))
      .map((parts) => MapEntry(parts[2], parts[0])));

  return map;
}

/// finds unsupported timezones from timezone package
/// and guess their country code
Map<String, String> unsupportedTimezones(Map<String, String> timezones) {
  String? guess(String timezoneId) {
    if (timezoneId == 'GMT' || timezoneId == 'UTC') return null;
    if (timezoneId.startsWith('US/')) return 'US';
    if (timezoneId.startsWith('Canada/')) return 'CA';
    if (timezoneId.startsWith('Australia/')) return 'AU';

    final code = {
      'America/Godthab': 'GL',
      'America/Montreal': 'CA',
      'America/Santa_Isabel': 'MX',
      'Asia/Rangoon': 'MM',
      'Europe/Kiev': 'UA',
      'Pacific/Enderbury': 'KI',
      'Pacific/Johnston': 'US',
    }[timezoneId];

    assert(code != null, 'You should implement: $timezoneId.');
    return code;
  }

  tz.initializeTimeZones();
  final unsupported = Map.fromEntries(() sync* {
    for (final timezoneId in tz.timeZoneDatabase.locations.keys
        .where((timezoneId) => timezones[timezoneId] == null)) {
      final code = guess(timezoneId);
      if (code != null) yield MapEntry(timezoneId, code);
    }
  }());
  return unsupported;
}

Future<void> generateSourceFile(
    String fileName, String mapName, Map<String, String> timezones) async {
  /// write to source file
  final sb = StringBuffer();
  sb.writeln("part of 'timezone_to_country.dart';");
  sb.writeln('');
  sb.writeln('const $mapName = ${convert.jsonEncode(timezones)};');
  sb.writeln('');

  final sourcePath = '../lib/$fileName';
  File(sourcePath)
    ..writeAsStringSync(
      sb.toString(),
    );

  /// format file
  await Process.run('flutter', ['format', sourcePath]);

  print('$fileName is updated.');
}
