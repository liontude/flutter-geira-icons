import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

const geiraIconsRepo =
    'https://raw.githubusercontent.com/Templarian/MaterialDesign-Webfont';
const fontFile = '$geiraIconsRepo/master/fonts/GeiraIcons-Regular.ttf';
const icons = '$geiraIconsRepo/master/scss/_variables.scss';

const reservedKeywords = ['null', 'switch', 'sync', 'factory'];

Future<void> download(String link, String name) async {
  try {
    final request = await HttpClient().getUrl(Uri.parse(link));
    final response = await request.close();
    await response.pipe(File(name).openWrite());
    if (kDebugMode) {
      print('Downloaded $name successfully.');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error downloading $name: $e');
    }
  }
}

String toCamelCase(String str) {
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

class IconInfo {
  String? name;
  String? identifier;
  String? codePoint;

  IconInfo({this.name, this.codePoint, this.identifier});
}

class GIconsInfo {
  List<IconInfo>? icons;
  String? version;
  GIconsInfo({this.icons, this.version});
}

Future<GIconsInfo> readScss() async {
  String? version;
  bool isIconStarted = false;
  final icons = <IconInfo>[];

  try {
    final lines = await File('./tool/_variables.scss').readAsLines();

    for (final line in lines) {
      version ??= RegExp(r'version:\s+"(.+?)"').firstMatch(line)?.group(1);

      if (!isIconStarted && line.contains('geira-icons: (')) {
        isIconStarted = true;
        continue;
      }

      if (isIconStarted && line.contains(')')) break;

      final match = RegExp(r'"([a-z0-9-]+)":\s+([0-9A-F]+)').firstMatch(line);
      if (match != null) {
        var iconName = match.group(1);
        var iconIdentifier = toCamelCase(iconName!);
        if (reservedKeywords.contains(iconIdentifier)) {
          iconIdentifier += 'Icon';
        }
        final codePoint = match.group(2)!.toLowerCase();

        icons.add(IconInfo(
            name: iconName, identifier: iconIdentifier, codePoint: codePoint));
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error reading SCSS: $e');
    }
  }

  return GIconsInfo(icons: icons, version: version);
}

Future<void> generateCode(
    {required String template,
    required String dest,
    required GIconsInfo info}) async {
  try {
    final templateFile = await File(template).readAsString();
    final placeholderMatch = RegExp(r'<%(.*?)%>').firstMatch(templateFile);

    if (placeholderMatch != null) {
      final placeholder = placeholderMatch.group(0)!;
      final templateStatement = placeholderMatch.group(1)!;

      final generated = templateFile.replaceAll(
        placeholder,
        info.icons!.map((icon) {
          return templateStatement
              .replaceAll('__ICON_NAME__', icon.identifier!)
              .replaceAll('__ORIGINAL_ICON_NAME__', icon.name!)
              .replaceAll('__CODE_POINT__', '0x${icon.codePoint}');
        }).join('\n'),
      );

      await File(dest).writeAsString(generated);
      if (kDebugMode) {
        print('Generated $dest successfully.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error generating code for $dest: $e');
    }
  }
}

Future<void> main() async {
  if (kDebugMode) {
    print('Downloading latest Geira icons...');
  }
  await download(fontFile, './tool/GeiraIcons-Regular.ttf');
  await download(icons, './tool/_variables.scss');

  if (kDebugMode) {
    print('Parsing SCSS file...');
  }
  final info = await readScss();

  if (kDebugMode) {
    print('Generating Dart files...');
  }
  await generateCode(
    template: './tool/geira_icons.dart.template',
    dest: './lib/geira_icons.dart',
    info: info,
  );
  await generateCode(
    template: './tool/icons_map.dart.template',
    dest: './lib/icons_map.dart',
    info: info,
  );

  try {
    File('./tool/GeiraIcons-Regular.ttf')
        .renameSync('./lib/fonts/GeiraIcons-Regular.ttf');
    File('./tool/_variables.scss').deleteSync();
  } catch (e) {
    if (kDebugMode) {
      print('Error moving files: $e');
    }
  }

  final spec = await File('./pubspec.yaml').readAsString();
  final versionMatch =
      RegExp(r'version:\s(\d+)\.(\d+)\.(\d+)').firstMatch(spec);
  final currentVersion = versionMatch?[3] ?? '0';
  final latestVersion = info.version?.replaceAll('.', '') ?? '0';

  if (kDebugMode) {
    print('Done! Latest version: ${info.version}');
  }
  if (kDebugMode) {
    print('Need to publish: ${currentVersion != latestVersion}');
  }
}
