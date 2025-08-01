// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:student_chatbot/pages/signup_page.dart';
// import 'package:student_chatbot/pages/login_page.dart';
// import 'fake_service.dart';
//
// void main() {
//   final binding =
//       TestWidgetsFlutterBinding.ensureInitialized()
//           as TestWidgetsFlutterBinding;
//   setUpAll(() {
//     debugPrint('=== SETUP signup_page_test ===');
//     binding.window.physicalSizeTestValue = const Size(1080, 1920);
//     binding.window.devicePixelRatioTestValue = 1.0;
//   });
//   tearDownAll(() {
//     debugPrint('=== TEARDOWN signup_page_test ===');
//     binding.window.clearPhysicalSizeTestValue();
//     binding.window.clearDevicePixelRatioTestValue();
//   });
//
//   group('SignupPage widget tests', () {
//     testWidgets('Test1: simple UI ', (tester) async {
//       debugPrint('[Test1] Pump SignupPage');
//       await tester.pumpWidget(MaterialApp(home: SignupPage()));
//       await tester.pumpAndSettle();
//       debugPrint('[Test1] Check BackButton');
//       expect(find.byType(BackButton), findsOneWidget);
//       debugPrint('[Test1] Check 4 TextField');
//       expect(find.byType(TextField), findsNWidgets(4));
//       debugPrint('[Test1] Check Create Account button');
//       expect(
//         find.widgetWithText(FilledButton, 'Create Account'),
//         findsOneWidget,
//       );
//       debugPrint('[Test1] UI passed');
//     });
//
//     testWidgets('Test2: BackButton pop', (tester) async {
//       debugPrint('[Test2] Setup Navigator');
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
//                 child: const Text('GoToSignup'),
//               );
//             },
//           ),
//         ),
//       );
//       await tester.pumpAndSettle();
//       debugPrint('[Test2] Tap GoToSignup');
//       await tester.tap(find.byKey(const Key('go')));
//       await tester.pumpAndSettle();
//       expect(find.byType(SignupPage), findsOneWidget);
//       debugPrint('[Test2] Tap BackButton');
//       await tester.tap(find.byType(BackButton));
//       await tester.pumpAndSettle();
//       expect(find.text('GoToSignup'), findsOneWidget);
//       debugPrint('[Test2] Back navigation passed');
//     });
//
//     testWidgets('Test3: Signup thành công → LoginPage', (tester) async {
//       // 1) Pump SignUpPage với fake service và route /login
//       await tester.pumpWidget(
//         MaterialApp(
//           routes: {'/login': (_) => LoginPage()},
//           home: SignupPage(
//             authService: FakeAuthService(shouldSignUpSucceed: true),
//           ),
//         ),
//       );
//       // chờ build xong
//       await tester.pumpAndSettle();
//
//       // 2) Điền form
//       await tester.enterText(find.byType(TextField).at(0), 'a@b.com');
//       await tester.enterText(find.byType(TextField).at(1), 'user');
//       await tester.enterText(find.byType(TextField).at(2), 'pass');
//       await tester.enterText(find.byType(TextField).at(3), 'pass');
//       await tester.pumpAndSettle();
//
//       // 3) Tap đúng FilledButton
//       await tester.tap(find.widgetWithText(FilledButton, 'Create Account'));
//
//
//       await tester.pump();                   // frame đầu
//       await tester.pump(const Duration(milliseconds: 300)); // cho animation (nếu có)
//       await tester.pumpAndSettle();          // đến khi ổn định
//
//       // 4) Verify LoginPage đã hiện
//       expect(find.byType(LoginPage), findsOneWidget);
//     });
//   });
// }
