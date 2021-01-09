import 'dart:convert' as convert;
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  /// download the timezone file
  final url = 'https://raw.githubusercontent.com/eggert/tz/master/zone.tab';
  final response = await http.get(url);
  if (response.statusCode != 200) {
    print('Request failed with status: ${response.statusCode}.');
    return;
  }

  // parse timezone
  final lines = response.body.split('\n');
  final map = Map.fromEntries(lines
      .where((line) => !line.startsWith('#') && line.isNotEmpty)
      .map((line) => line.split('\t'))
      .map((parts) => MapEntry(parts[2], parts[0])));

  /// write to source file
  final sb = StringBuffer();
  sb.writeln("part of 'timezone_to_country.dart';");
  sb.writeln('');
  sb.writeln('const _map = ${convert.jsonEncode(map)};');
  sb.writeln('');
  sb.writeln('String _lookup(String timezoneId) => _map[timezoneId];');
  sb.writeln('');

  final sourcePath = '../lib/timezone_to_country.g.dart';
  File(sourcePath)
    ..writeAsStringSync(
      sb.toString(),
    );
  Process.runSync('flutter', ['format', sourcePath]);

  print('File updated');
}
