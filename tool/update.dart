import 'dart:async';
import 'dart:io';

const geiraIconsRepo = 'https://raw.githubusercontent.com/Templarian/MaterialDesign-Webfont';
const fontFile = '$geiraIconsRepo/master/fonts/GeiraIcons-Regular.ttf';
const icons = '$geiraIconsRepo/master/scss/_variables.scss';

const reversedKeywords = ['null', 'switch', 'sync', 'factory'];

Future download(String link, String name) {
  return (new HttpClient().getUrl(Uri.parse(link)).then((HttpClientRequest request) => request.close()).then((HttpClientResponse response) => response.pipe(new File(name).openWrite())));
}

String toCamelCase(String str) {
  RegExp exp = new RegExp(r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+');
  Iterable<Match> matches = exp.allMatches(str);
  if (matches.isEmpty) return '';
  String res = '';
  for (Match m in matches) {
    String match = m.group(0)!;
    res += match.substring(0, 1).toUpperCase() + match.substring(1).toLowerCase();
  }
  return res.substring(0, 1).toLowerCase() + res.substring(1);
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

Future<GIconsInfo> readScss() {
  String? version;
  bool isIconStarted = false;
  List<IconInfo> icons = [];
  return File('./tool/_variables.scss').readAsLines().then((lines) {
    lines.forEach((line) {
      if (version == null) {
        Match? match = RegExp(r'version:\s+"(.+)"\s').firstMatch(line);
        if (match != null && match.group(1) != null) {
          version = match.group(1);
        }
      }
      if (!isIconStarted) {
        // is the open parenthesis, where icons start next line
        Iterable<Match> matches = RegExp(r'geira-icons:\s\(').allMatches(line);
        if (matches.isNotEmpty) {
          isIconStarted = true;
        }
      } else {
        // is the close parenthesis, where icons are all loaded.
        bool isEndOfIcons = line.indexOf(')') >= 0;
        if (!isEndOfIcons) {
          Match? match = RegExp(r'"([a-z0-9-]+)"\:\s+([0-9A-F]+)').firstMatch(line);
          if (match != null) {
            String? iconName = match.group(1);
            String iconIdentifier = toCamelCase(match.group(1)!);
            if (reversedKeywords.contains(iconIdentifier)) {
              iconIdentifier += 'Icon';
            }
            String codePoint = match.group(2)!.toLowerCase();
            icons.add(IconInfo(name: iconName, identifier: iconIdentifier, codePoint: codePoint));
          }
        }
      }
    });
    return GIconsInfo(icons: icons, version: version);
  });
}

Future generateCode({required String template, String? dest, GIconsInfo? info}) async {
  String templateFile = await File(template).readAsString();
  Match? match = RegExp(r'<%(.*)%>').firstMatch(templateFile);
  if (match != null) {
    String placeholder = match.group(0)!;
    String? templateStatment = match.group(1);
    String generated = templateFile.replaceAll(
        placeholder,
        info!.icons!.map((icon) {
          return templateStatment!.replaceAll('__ICON_NAME__', icon.identifier!).replaceAll('__ORIGINAL_ICON_NAME__', icon.name!).replaceAll('__CODE_POINT__', '0x${icon.codePoint}');
        }).join('\n'));
    await File(dest!).writeAsString(generated);
  }
}

main() async {
  print('downloading latest geira icons');
  await download(fontFile, './tool/GeiraIcons-Regular.ttf');
  await download(icons, './tool/_variables.scss');
  print('parsing');
  var info = await readScss();
  print('generating');
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
  File('./tool/GeiraIcons-Regular.ttf').renameSync('./lib/fonts/GeiraIcons-Regular.ttf');
  File('./tool/_variables.scss').deleteSync();
  var spec = File('./pubspec.yaml').readAsStringSync();
  var match = RegExp(r'version:\s(\d+)\.(\d+)\.(\d+)').firstMatch(spec)!;
  var currentVersion = match[3];
  var latestVersion = info.version!.replaceAll('.', '');
  print('done, latest version: ${info.version}, need publish: ${currentVersion != latestVersion}');
  exit(0);
}
