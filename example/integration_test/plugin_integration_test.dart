import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:geira_icons/geira_icons.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Verify GIcons basic functionality', (WidgetTester tester) async {
    // Verificar si los iconos se pueden obtener correctamente
    expect(GIcons.fromString('pencil'), equals(GIcons.pencil));
    expect(GIcons.fromString('wifi'), equals(GIcons.wifi));
    expect(GIcons.fromString('unknown'), isNull);

    // Verificar que getIconsName devuelve una lista no vacía
    final iconsList = GIcons.getIconsName();
    expect(iconsList.isNotEmpty, true);
    expect(iconsList, contains('pencil'));
  });
}
