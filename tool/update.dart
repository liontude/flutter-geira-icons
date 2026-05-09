import 'dart:convert';
import 'dart:io';

const _fontUrl =
    'https://cdn.jsdelivr.net/npm/@geira/iconfont/dist/fonts/GeiraIcons-Regular.ttf';
const _jsonUrl =
    'https://cdn.jsdelivr.net/npm/@geira/iconfont/dist/icons.json';

const _reservedKeywords = ['null', 'switch', 'sync', 'factory'];

Future<void> _download(String url, String dest) async {
  final request = await HttpClient().getUrl(Uri.parse(url));
  final response = await request.close();
  await response.pipe(File(dest).openWrite());
  print('Downloaded $dest');
}

String _toCamelCase(String str) {
  final exp = RegExp(
      r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+');
  final matches = exp.allMatches(str);
  if (matches.isEmpty) return '';

  return matches
      .map((m) {
        final match = m.group(0)!;
        return match.substring(0, 1).toUpperCase() +
            match.substring(1).toLowerCase();
      })
      .join()
      .replaceFirstMapped(RegExp(r'^[A-Z]'), (m) => m.group(0)!.toLowerCase());
}

class _IconInfo {
  final String name;
  final String identifier;
  final String codePoint;

  const _IconInfo({
    required this.name,
    required this.identifier,
    required this.codePoint,
  });
}

class _GIconsInfo {
  final List<_IconInfo> icons;
  final String version;

  const _GIconsInfo({required this.icons, required this.version});
}

Future<_GIconsInfo> _parseJson() async {
  final content = await File('./tool/icons.json').readAsString();
  final data = jsonDecode(content) as Map<String, dynamic>;
  final version = data['version'] as String;
  final rawIcons = data['icons'] as Map<String, dynamic>;

  final icons = rawIcons.entries.map((e) {
    final name = e.key;
    var identifier = _toCamelCase(name);
    if (_reservedKeywords.contains(identifier)) identifier += 'Icon';
    final codePoint = '0x${(e.value as String).toLowerCase()}';
    return _IconInfo(name: name, identifier: identifier, codePoint: codePoint);
  }).toList();

  return _GIconsInfo(icons: icons, version: version);
}

Future<void> _generateCode({
  required String template,
  required String dest,
  required _GIconsInfo info,
}) async {
  final templateContent = await File(template).readAsString();
  final placeholderMatch =
      RegExp(r'<%(.*?)%>', dotAll: true).firstMatch(templateContent);

  if (placeholderMatch == null) {
    print('No placeholder found in $template');
    return;
  }

  final placeholder = placeholderMatch.group(0)!;
  final templateStatement = placeholderMatch.group(1)!;

  final generated = templateContent.replaceAll(
    placeholder,
    info.icons.map((icon) {
      return templateStatement
          .replaceAll('__ICON_NAME__', icon.identifier)
          .replaceAll('__ORIGINAL_ICON_NAME__', icon.name)
          .replaceAll('__CODE_POINT__', icon.codePoint);
    }).join('\n'),
  );

  await File(dest).writeAsString(generated);
  print('Generated $dest');
}

Future<void> _updatePubspecVersion(String version) async {
  final file = File('./pubspec.yaml');
  final content = await file.readAsString();
  final updated =
      content.replaceFirst(RegExp(r'version:\s+\S+'), 'version: $version');
  await file.writeAsString(updated);
  print('Updated pubspec.yaml to version $version');
}

Future<void> main() async {
  print('Downloading latest Geira icons...');
  await Future.wait([
    _download(_fontUrl, './tool/GeiraIcons-Regular.ttf'),
    _download(_jsonUrl, './tool/icons.json'),
  ]);

  print('Parsing icons.json...');
  final info = await _parseJson();

  print('Generating Dart files...');
  await Future.wait([
    _generateCode(
      template: './tool/geira_icons.dart.template',
      dest: './lib/geira_icons.dart',
      info: info,
    ),
    _generateCode(
      template: './tool/icons_map.dart.template',
      dest: './lib/src/icons_map.dart',
      info: info,
    ),
  ]);

  File('./tool/GeiraIcons-Regular.ttf')
      .renameSync('./lib/fonts/GeiraIcons-Regular.ttf');
  File('./tool/icons.json').deleteSync();

  await _updatePubspecVersion(info.version);

  print('Done! Version: ${info.version}');
}
