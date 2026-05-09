import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A6FFF)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6FFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
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
  final _searchController = SearchController();
  String _searchTerm = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allNames = GIcons.iconNames.toList();
    final filteredNames = _searchTerm.isEmpty
        ? allNames
        : allNames
            .where((n) => n.toLowerCase().contains(_searchTerm.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geira Icons'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search ${allNames.length} icons…',
              leading: const Icon(GIcons.search),
              trailing: [
                if (_searchTerm.isNotEmpty)
                  IconButton(
                    icon: const Icon(GIcons.close),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchTerm = '');
                    },
                  ),
              ],
              onChanged: (value) => setState(() => _searchTerm = value),
            ),
          ),
        ),
      ),
      body: filteredNames.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    GIcons.search,
                    size: 48,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No icons found for "$_searchTerm"',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount =
                    (constraints.maxWidth / 110).floor().clamp(2, 8);
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filteredNames.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final name = filteredNames[index];
                    final iconData = GIcons.byName(name)!;
                    return _IconTile(name: name, iconData: iconData);
                  },
                );
              },
            ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.name, required this.iconData});

  final String name;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card.filled(
      color: colorScheme.surfaceContainerHighest,
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => _IconDetailPage(name: name, iconData: iconData),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: name,
              child: Icon(iconData, size: 32, color: colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconDetailPage extends StatelessWidget {
  const _IconDetailPage({required this.name, required this.iconData});

  final String name;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final codePoint =
        '0x${iconData.codePoint.toRadixString(16).toUpperCase()}';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(GIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(GIcons.share),
            tooltip: 'Copy icon name',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: name));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Copied "$name" to clipboard'),
                  behavior: SnackBarBehavior.floating,
                  width: 280,
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: name,
              child: Icon(iconData, size: 120, color: colorScheme.primary),
            ),
            const SizedBox(height: 32),
            Text(name, style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                codePoint,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
