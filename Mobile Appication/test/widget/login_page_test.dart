// // test/widget/signup_page_test.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:student_chatbot/pages/signup_page.dart';
// import 'package:student_chatbot/pages/login_page.dart';
// import 'fake_service.dart'; // chứa FakeAuthService
//
// void main() {
//   final binding =
//       TestWidgetsFlutterBinding.ensureInitialized()
//           as TestWidgetsFlutterBinding;
//
//   setUpAll(() {
//     debugPrint('=== SETUP signup_page_test ===');
//     // ép window size để tránh overflow
//     binding.window.physicalSizeTestValue = const Size(1080, 1920);
//     binding.window.devicePixelRatioTestValue = 1.0;
//   });
//
//   tearDownAll(() {
//     debugPrint('=== TEARDOWN signup_page_test ===');
//     binding.window.clearPhysicalSizeTestValue();
//     binding.window.clearDevicePixelRatioTestValue();
//   });
//
//   group('SignupPage widget tests', () {
//     testWidgets('Test1: simple UI', (tester) async {
//       debugPrint('[Test1] Pump SignupPage');
//       await tester.pumpWidget(
//         MaterialApp(home: SignupPage()),
//       );
//       await tester.pumpAndSettle();
//
//       debugPrint('[Test1] Check BackButton');
//       expect(find.byType(BackButton), findsOneWidget);
//
//       debugPrint('[Test1] Check 4 TextField');
//       expect(find.byType(TextField), findsNWidgets(4));
//
//       debugPrint('[Test1] Check Create Account button');
//       expect(
//         find.widgetWithText(FilledButton, 'Create Account'),
//         findsOneWidget,
//       );
//       debugPrint('[Test1] UI passed');
//     });
//
//     testWidgets('Test2: BackButton pop for previous page', (tester) async {
//       debugPrint('[Test2] Pump Navigator + SignupPage');
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Builder(
//             builder: (ctx) {
//               return TextButton(
//                 key: const Key('go'),
//                 onPressed:
//                     () => Navigator.of(
//                       ctx,
//                     ).push(MaterialPageRoute(builder: (_) => SignupPage())),
//                 child: const Text('Go'),
//               );
//             },
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//
//       debugPrint('[Test2] Tap to push SignupPage');
//       await tester.tap(find.byKey(const Key('go')));
//       await tester.pumpAndSettle();
//       expect(find.byType(SignupPage), findsOneWidget);
//
//       debugPrint('[Test2] Tap BackButton to pop');
//       await tester.tap(find.byType(BackButton));
//       await tester.pumpAndSettle();
//       expect(find.text('Go'), findsOneWidget);
//       debugPrint('[Test2] Back navigation passed');
//     });
//
//     testWidgets('Test3: Signup successfully → LoginPage', (tester) async {
//       debugPrint('[Test3] Pump SignupPage with FakeAuthService');
//       await tester.pumpWidget(
//         MaterialApp(
//           routes: {'/login': (_) => LoginPage()},
//           home: SignupPage(
//             authService: FakeAuthService(shouldSignUpSucceed: true),
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//
//       debugPrint('[Test3] Ipnut email, username, password, verify');
//       await tester.enterText(find.byType(TextField).at(0), 'a@b.com');
//       await tester.enterText(find.byType(TextField).at(1), 'user');
//       await tester.enterText(find.byType(TextField).at(2), 'pass');
//       await tester.enterText(find.byType(TextField).at(3), 'pass');
//       await tester.pumpAndSettle();
//
//       debugPrint('[Test3] Tap Create Account');
//       await tester.tap(find.widgetWithText(FilledButton, 'Create Account'));
//
//       // Chờ Navigator chuyển route
//       await tester.pumpAndSettle();
//
//       debugPrint('[Test3] Verify LoginPage is shown');
//       expect(find.byType(LoginPage), findsOneWidget);
//       debugPrint('[Test3] Navigation passed');
//     });
//   });
// }
