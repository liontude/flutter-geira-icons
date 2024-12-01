import 'package:flutter/material.dart';
import 'package:geira_icons/geira_icons.dart';
import 'package:geira_icons/icons_map.dart';

void main() {
  runApp(GeiraIconsApp());
}

class GeiraIconsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geira Icons',
      theme: ThemeData(
        iconTheme: const IconThemeData(size: 36.0, color: Colors.black87),
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
      home: const GeiraIconsHome(),
    );
  }
}

class GeiraIconsHome extends StatefulWidget {
  const GeiraIconsHome({super.key});

  @override
  State<StatefulWidget> createState() => GeiraIconsHomeState();
}

class GeiraIconsHomeState extends State<GeiraIconsHome> {
  var _searchTerm = "";
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filteredIcons = icons
        .where((icon) =>
            _searchTerm.isEmpty ||
            icon.title.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();

    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: _isSearching ? _searchBar(context) : _titleBar(),
      body: GridView.builder(
        itemCount: filteredIcons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        ),
        itemBuilder: (context, index) {
          final icon = filteredIcons[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        child: SizedBox.expand(
                          child: Hero(
                            tag: icon,
                            child: Icon(
                              icon.iconData,
                              size: 100.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(tag: icon, child: Icon(icon.iconData)),
                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(icon.title),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _titleBar() {
    return AppBar(
      title: const Text("Geira Icons"),
      actions: [
        IconButton(
          icon: const Icon(GIcons.search),
          onPressed: () {
            ModalRoute.of(context)?.addLocalHistoryEntry(
              LocalHistoryEntry(
                onRemove: () {
                  setState(() {
                    _searchTerm = "";
                    _isSearching = false;
                  });
                },
              ),
            );

            setState(() {
              _isSearching = true;
            });
          },
        )
      ],
    );
  }

  AppBar _searchBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(GIcons.search),
        onPressed: () {
          setState(() {
            Navigator.pop(context);
            _isSearching = false;
            _searchTerm = "";
          });
        },
      ),
      title: TextField(
        onChanged: (text) => setState(() => _searchTerm = text),
        autofocus: true,
        style: const TextStyle(fontSize: 18.0),
        decoration: const InputDecoration(
          hintText: "Search icons...",
        ),
      ),
    );
  }
}

class IconDefinition implements Comparable {
  final IconData iconData;
  final String title;

  IconDefinition(String key)
      : iconData = iconLib[key] ?? GIcons.error,
        title = key;

  @override
  String toString() => 'IconDefinition{iconData: $iconData, title: $title}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconDefinition &&
          runtimeType == other.runtimeType &&
          iconData == other.iconData &&
          title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(other) => title.compareTo(other.title);
}

// Assuming the following corrections for missing/undefined parts:
GIcons iconLib = GIcons();
var icons = iconMap.keys
    .map((key) => IconDefinition(key))
    .toList(); // Añadido "toList()" para evitar problemas
