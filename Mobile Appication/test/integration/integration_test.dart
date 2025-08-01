// integration_test/app_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:student_chatbot/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end: Signup → Login → Chat', () {
    testWidgets('complete user journey', (tester) async {
      // 1) Khởi chạy app
      app.main();
      await tester.pumpAndSettle();

      // 2) Điều hướng đến Signup (nếu app khởi đầu ở Login)
      final toSignup = find.text('Create Account');
      expect(toSignup, findsOneWidget);
      await tester.tap(toSignup);
      await tester.pumpAndSettle();

      // 3) Điền form signup
      await tester.enterText(find.byKey(const Key('signup_email')), 'e2e@demo.com');
      await tester.enterText(find.byKey(const Key('signup_username')), 'e2euser');
      await tester.enterText(find.byKey(const Key('signup_password')), 'password123');
      await tester.enterText(find.byKey(const Key('signup_verify')), 'password123');
      await tester.tap(find.byKey(const Key('signup_button')));
      await tester.pumpAndSettle();

      // 4) Sau signup thành công, app push sang LoginPage
      expect(find.byKey(const Key('login_email')), findsOneWidget);

      // 5) Điền login
      await tester.enterText(find.byKey(const Key('login_email')), 'e2e@demo.com');
      await tester.enterText(find.byKey(const Key('login_password')), 'password123');
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // 6) Sau login thành công, HomePage hiện lên với AppBar
      expect(find.byType(AppBar), findsOneWidget);

      // 7) Vào chat: nhập tin nhắn và gửi
      await tester.enterText(find.byKey(const Key('chat_input')), 'Hello e2e!');
      await tester.tap(find.byKey(const Key('send_button')));
      // có thể chờ 1–2 giây nếu server thật, hoặc stub network trong môi trường e2e
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // 8) Kỳ vọng tin nhắn user và tin nhắn phản hồi (từ bot) xuất hiện
      expect(find.text('Hello e2e!'), findsOneWidget);
      expect(find.textContaining('Bot'), findsWidgets);

      // 9) Optional: mở Drawer → Settings
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.expand_less));
      await tester.pumpAndSettle();
      expect(find.text('Setting'), findsOneWidget);
    });
  });
}
