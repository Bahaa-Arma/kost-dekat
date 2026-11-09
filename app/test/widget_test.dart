import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kosdekat/main.dart';
import 'package:kosdekat/services/api_service.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('KosDekatApp smoke test', (tester) async {
    final client = MockClient((request) async {
      return http.Response('[]', 200, headers: {'content-type': 'application/json'});
    });
    final api = ApiService(baseUrl: 'http://localhost:8080', client: client);
    await tester.pumpWidget(KosDekatApp(api: api));
    expect(find.text('KosDekat'), findsOneWidget);
    api.dispose();
  });
}
