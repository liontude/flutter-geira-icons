import 'package:flutter/material.dart';
import 'package:geira_icons/geira_icons.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        iconTheme: const IconThemeData(size: 42.0, color: Colors.black87),
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
  String _searchTerm = '';
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final allNames = GIcons.iconNames.toList();
    final filteredNames = _searchTerm.isEmpty
        ? allNames
        : allNames
            .where((name) =>
                name.toLowerCase().contains(_searchTerm.toLowerCase()))
            .toList();

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: _isSearching ? _buildSearchBar() : _buildTitleBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: filteredNames.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait ? 2 : 4,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          final name = filteredNames[index];
          final iconData = GIcons.byName(name)!;
          return InkWell(
            onTap: () => _showIconDetail(context, name, iconData),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(tag: name, child: Icon(iconData)),
                const SizedBox(height: 8.0),
                Text(name, style: const TextStyle(fontSize: 14.0)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showIconDetail(BuildContext context, String name, IconData iconData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(GIcons.chevronLeft, size: 32.0),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(name),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Hero(tag: name, child: Icon(iconData, size: 100.0)),
          ),
        ),
      ),
    );
  }

  AppBar _buildTitleBar() {
    return AppBar(
      title: const Text('Geira Icons'),
      actions: [
        IconButton(
          icon: const Icon(GIcons.search, size: 32.0),
          onPressed: () {
            ModalRoute.of(context)?.addLocalHistoryEntry(
              LocalHistoryEntry(
                onRemove: () => setState(() {
                  _searchTerm = '';
                  _isSearching = false;
                }),
              ),
            );
            setState(() => _isSearching = true);
          },
        ),
      ],
    );
  }

  AppBar _buildSearchBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(GIcons.chevronLeft, size: 32.0),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            _isSearching = false;
            _searchTerm = '';
          });
        },
      ),
      title: TextField(
        onChanged: (text) => setState(() => _searchTerm = text),
        autofocus: true,
        style: const TextStyle(fontSize: 18.0),
        decoration: const InputDecoration(
          hintText: 'Search icons...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
