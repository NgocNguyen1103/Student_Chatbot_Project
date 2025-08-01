// // test/widget/home_page_test.dart
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:student_chatbot/models/chat_session.dart';
// import 'package:student_chatbot/pages/home_page.dart';
// import 'fake_service.dart';
//
// void main() {
//   late ChatSession session;
//   late FakeChatService fakeChat;
//
//   setUp(() {
//     session = ChatSession(
//       id: 42,
//       title: 'My Session',
//       userId: 99,
//       createdAt: DateTime.parse('2023-01-01T12:00:00Z'),
//       lastMessage: DateTime.parse('2023-01-01T12:00:00Z'),
//     );
//     fakeChat = FakeChatService(fakeSession: session);
//   });
//
//   testWidgets('HomePage draws, opens drawer & navigates to ChatPage', (tester) async {
//     // 1) pump your HomePage with constructor injection:
//     await tester.pumpWidget(
//       MaterialApp(
//         home: HomePage(
//           method: 'login',
//           token: 'fake-token',
//           chatService: fakeChat,
//           // you can inject a FakeAuthService too if you need the Settings tile…
//         ),
//       ),
//     );
//     await tester.pumpAndSettle();
//
//     // 2) it should show an AppBar and a menu‐button
//     expect(find.byType(AppBar), findsOneWidget);
//     expect(find.byTooltip('Open navigation menu'), findsOneWidget);
//
//     // 3) open the drawer
//     await tester.tap(find.byTooltip('Open navigation menu'));
//     await tester.pumpAndSettle();
//     expect(find.text('Chat History'), findsOneWidget);
//
//     // 4) close drawer, send a message…
//     await tester.tap(find.byIcon(Icons.arrow_back)); // or however you close it
//     await tester.pumpAndSettle();
//
//     // enter text into the bottom input
//     final input = find.byType(TextField).last;
//     await tester.enterText(input, 'Hello world');
//     await tester.pump();
//
//     // tap the send‐icon
//     // await tester.tap(find.byIcon(Icons.send));
//     // await tester.pumpAndSettle();
//     //
//     // // 5) because our fake returned {"session":{…}}, HomePage should now push a ChatPage
//     // expect(find.byType(ChatPage), findsOneWidget);
//   });
// }
