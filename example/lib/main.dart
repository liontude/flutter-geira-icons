import 'package:flutter/material.dart';
import 'package:geira_icons/geira_icons.dart';
import 'package:geira_icons/icons_map.dart';

void main() {
  runApp(const GeiraIconsApp());
}

class GeiraIconsApp extends StatelessWidget {
  const GeiraIconsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geira Icons',
      theme: ThemeData(
        iconTheme: const IconThemeData(size: 42.0, color: Colors.black87),
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
  State<GeiraIconsHome> createState() => _GeiraIconsHomeState();
}

class _GeiraIconsHomeState extends State<GeiraIconsHome> {
  String _searchTerm = "";
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filteredIcons = icons
        .where(
          (icon) =>
              _searchTerm.isEmpty ||
              icon.title.toLowerCase().contains(_searchTerm.toLowerCase()),
        )
        .toList();

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: _isSearching ? _buildSearchBar() : _buildTitleBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: filteredIcons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait
              ? 2
              : 4, // 📱 More icons per row in landscape mode
          mainAxisSpacing: 8.0, // ✅ Reduced vertical spacing
          crossAxisSpacing: 8.0, // ✅ Reduced horizontal spacing
        ),
        itemBuilder: (context, index) {
          final icon = filteredIcons[index];

          return InkWell(
            onTap: () => _showIconDetail(context, icon), // 👆 Handle icon tap
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: icon.title,
                  child: Icon(icon.iconData),
                ), // 🚀 Smooth transition effect
                const SizedBox(height: 8.0), // ✅ Space between icon and text
                Text(icon.title, style: const TextStyle(fontSize: 14.0)),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🚀 Navigates to a new screen showing the icon in a larger view
  void _showIconDetail(BuildContext context, IconDefinition icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(GIcons.chevronLeft, size: 32.0),
              onPressed: () => Navigator.pop(context), // 🔙 Go back button
            ),
            title: Text(icon.title),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Hero(
              tag: icon.title,
              child: Icon(icon.iconData, size: 100.0), // 🔍 Enlarged icon
            ),
          ),
        ),
      ),
    );
  }

  // 🗂️ Default AppBar with title
  AppBar _buildTitleBar() {
    return AppBar(
      title: const Text("Geira Icons"),
      actions: [
        IconButton(
          icon: const Icon(GIcons.search, size: 32.0),
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

            setState(() => _isSearching = true); // 🔍 Activate search mode
          },
        ),
      ],
    );
  }

  // 🔍 AppBar for search functionality
  AppBar _buildSearchBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(GIcons.chevronLeft, size: 32.0),
        onPressed: () {
          Navigator.pop(context); // 🔙 Exit search mode
          setState(() {
            _isSearching = false;
            _searchTerm = "";
          });
        },
      ),
      title: TextField(
        onChanged: (text) =>
            setState(() => _searchTerm = text), // 🔎 Live search filter
        autofocus: true,
        style: const TextStyle(fontSize: 18.0),
        decoration: const InputDecoration(
          hintText: "Search icons...",
          border: InputBorder.none, // ✅ Clean, borderless search bar
        ),
      ),
    );
  }
}

// 📦 Class to define icons
class IconDefinition implements Comparable<IconDefinition> {
  final IconData iconData;
  final String title;

  IconDefinition(String key)
    : iconData = iconMap[key] ?? GIcons.error, // ✅ Use iconMap directly
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
  int compareTo(IconDefinition other) => title.compareTo(other.title);
}

// ✅ Initialize icons from the iconMap
final List<IconDefinition> icons = iconMap.keys
    .map((key) => IconDefinition(key))
    .toList();
