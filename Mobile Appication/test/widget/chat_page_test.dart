// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:student_chatbot/pages/chat_page.dart';
// import 'package:student_chatbot/models/chat_session.dart';
// import 'package:student_chatbot/models/chat_message.dart';
// import 'fake_chat_service.dart';
//
// void main() {
//   final binding = TestWidgetsFlutterBinding.ensureInitialized()
//   as TestWidgetsFlutterBinding;
//   setUpAll(() {
//     debugPrint('=== SETUP chat_page_test ===');
//     binding.window.physicalSizeTestValue = const Size(1080, 1920);
//     binding.window.devicePixelRatioTestValue = 1.0;
//   });
//   tearDownAll(() {
//     debugPrint('=== TEARDOWN chat_page_test ===');
//     binding.window.clearPhysicalSizeTestValue();
//     binding.window.clearDevicePixelRatioTestValue();
//   });
//
//   final session = ChatSession(
//     id: 1,
//     title: 'S1',
//     userId: 1,
//     createdAt: DateTime.now(),
//     lastMessage: DateTime.now(),
//   );
//
//   testWidgets('Test1: Loading spinner', (tester) async {
//     debugPrint('[Test1] Pump ChatPage empty history');
//     await tester.pumpWidget(MaterialApp(
//       home: ChatPage(
//         session: session,
//         token: 'fake',
//         chatService: FakeChatService(history: [], reply: null),
//       ),
//     ));
//     debugPrint('[Test1] Verify CircularProgressIndicator');
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     await tester.pumpAndSettle();
//   });
//
//   testWidgets('Test2: Display history ChatBubble', (tester) async {
//     final history = [
//       ChatMessage(
//         id: 1,
//         chatSessionId: 1,
//         sender: 'user',
//         sequenceNo: 1,
//         content: 'Hi!',
//         createdAt: DateTime.now(),
//       ),
//       ChatMessage(
//         id: 2,
//         chatSessionId: 1,
//         sender: 'bot',
//         sequenceNo: 2,
//         content: 'Hello!',
//         createdAt: DateTime.now(),
//       ),
//     ];
//     debugPrint('[Test2] Pump ChatPage with 2 history messages');
//     await tester.pumpWidget(MaterialApp(
//       home: ChatPage(
//         session: session,
//         token: 'fake',
//         chatService: FakeChatService(history: history, reply: null),
//       ),
//     ));
//     await tester.pumpAndSettle();
//     debugPrint('[Test2] Verify 2 ChatBubble');
//     expect(find.byType(ChatBubble), findsNWidgets(2));
//     expect(find.text('Hi!'), findsOneWidget);
//     expect(find.text('Hello!'), findsOneWidget);
//   });
//
//   testWidgets('Test3: Send & receive', (tester) async {
//     debugPrint('[Test3] Pump ChatPage empty history');
//     await tester.pumpWidget(MaterialApp(
//       home: ChatPage(
//         session: session,
//         token: 'fake',
//         chatService: FakeChatService(
//           history: [],
//           reply: ChatMessage(
//             id: 3,
//             chatSessionId: 1,
//             sender: 'bot',
//             sequenceNo: 1,
//             content: 'Bot reply',
//             createdAt: DateTime.now(),
//           ),
//         ),
//       ),
//     ));
//     await tester.pumpAndSettle();
//     debugPrint('[Test3] Enter text "User msg"');
//     await tester.enterText(find.byType(TextField), 'User msg');
//     await tester.pump();
//     debugPrint('[Test3] Tap send icon');
//     await tester.tap(find.byIcon(Icons.send));
//     await tester.pump();
//     debugPrint('[Test3] Verify user msg');
//     expect(find.text('User msg'), findsOneWidget);
//     await tester.pumpAndSettle();
//     debugPrint('[Test3] Verify bot reply');
//     expect(find.text('Bot reply'), findsOneWidget);
//   });
// }
