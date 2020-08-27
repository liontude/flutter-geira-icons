import 'package:flutter/material.dart';
import 'package:geira_icons/geira_icons.dart';
import 'package:geira_icons/icons_map.dart';

void main() {
  runApp(new GeiraIconsApp());
}

class GeiraIconsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geira Icons',
      theme: new ThemeData(
        iconTheme: new IconThemeData(size: 36.0, color: Colors.black87),
        primarySwatch: Colors.blue,
        textTheme: new TextTheme(
          bodyText2: new TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
      home: new GeiraIconsHome(),
    );
  }
}

class GeiraIconsHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new GeiraIconsHomeState();
}

class GeiraIconsHomeState extends State<GeiraIconsHome> {
  var _searchTerm = "";
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filteredIcons = icons.where((icon) => _searchTerm.isEmpty || icon.title.toLowerCase().contains(_searchTerm.toLowerCase())).toList();
    final orientation = MediaQuery.of(context).orientation;

    return new Scaffold(
      appBar: _isSearching ? _searchBar(context) : _titleBar(),
      body: new GridView.builder(
          itemCount: filteredIcons.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
          ),
          itemBuilder: (context, index) {
            final icon = filteredIcons[index];

            return new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: new Container(
                          color: Colors.white,
                          child: new SizedBox.expand(
                            child: new Hero(
                              tag: icon,
                              child: new Icon(
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
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Hero(tag: icon, child: new Icon(icon.iconData)),
                  new Container(
                    padding: new EdgeInsets.only(top: 16.0),
                    child: new Text(icon.title),
                  ),
                ],
              ),
            );
          }),
    );
  }

  AppBar _titleBar() {
    return new AppBar(
      title: new Text("Geira Icons"),
      actions: [
        new IconButton(
            icon: new Icon(GIcons.search),
            onPressed: () {
              ModalRoute.of(context).addLocalHistoryEntry(
                new LocalHistoryEntry(
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
            })
      ],
    );
  }

  AppBar _searchBar(BuildContext context) {
    return new AppBar(
      leading: new IconButton(
        icon: new Icon(GIcons.search),
        onPressed: () {
          setState(
            () {
              Navigator.pop(context);
              _isSearching = false;
              _searchTerm = "";
            },
          );
        },
      ),
      title: new TextField(
        onChanged: (text) => setState(() => _searchTerm = text),
        autofocus: true,
        style: new TextStyle(fontSize: 18.0),
        decoration: new InputDecoration(),
      ),
    );
  }
}

class IconDefinition implements Comparable {
  IconData iconData;
  String title;

  IconDefinition(String key) {
    this.iconData = iconLib[key];
    this.title = key;
  }

  @override
  String toString() => 'IconDefinition{iconData: $iconData, title: $title}';

  @override
  bool operator ==(Object other) => identical(this, other) || other is IconDefinition && runtimeType == other.runtimeType && iconData == other.iconData && title == other.title;

  @override
  int get hashCode => iconData.hashCode ^ title.hashCode;

  @override
  int compareTo(other) => title.compareTo(other.title);
}

GIcons iconLib = new GIcons();

var icons = iconMap.keys.map((key) => IconDefinition(key));
