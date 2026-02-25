import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;

import 'timezone_compatibility.dart';

const String TIMEZONE_DATABASE_VERSION = '2025c';

void main() async {
  final timezones = await loadTimezonesWithCountryCodes(
    TIMEZONE_DATABASE_VERSION,
  );
  if (timezones.isEmpty) return;

  generateSourceFile('timezone_to_country.g.dart', '_map', timezones);

  final unsupported = findUnmappedTimezonesWithCountryCodes(timezones);
  if (unsupported.isEmpty) return;

  generateSourceFile('timezone_to_country.manual.g.dart', '_map2', unsupported);
}

/// load timezones with their country code from tz database
Future<Map<String, String>> loadTimezonesWithCountryCodes(
  String version,
) async {
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

Future<void> generateSourceFile(
  String fileName,
  String mapName,
  Map<String, String> timezones,
) async {
  /// write to source file
  final sb = StringBuffer();
  sb.writeln("part of 'timezone_to_country.dart';");
  sb.writeln('');
  sb.writeln('const $mapName = ${convert.jsonEncode(timezones)};');
  sb.writeln('');

  final sourcePath = '../lib/$fileName';
  await File(sourcePath).writeAsString(sb.toString());

  /// format file
  await Process.run('dart', ['format', sourcePath]);

  print('$fileName is updated.');
}
