// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:student_chatbot/main.dart' as app;
//
// void main() {
//   final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
//   as IntegrationTestWidgetsFlutterBinding;
//   // Chế độ đo benchmark
//   binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.benchmark;
//   testWidgets('Measure app startup time', (tester) async {
//     final sw = Stopwatch()..start();
//     app.main();
//     await tester.pumpAndSettle();
//     sw.stop();
//     print('🕒 Time to ready: ${sw.elapsedMilliseconds} ms');
//   });
//   testWidgets('Scroll chat list performance', (tester) async {
//     app.main();
//     await tester.pumpAndSettle();
//     // Bắt đầu trace action
//     await binding.traceAction(() async {
//       // Thao tác cuộn
//       await tester.fling(find.byType(ListView), const Offset(0, -300), 1000);
//       await tester.pumpAndSettle();
//     });
//     // Kết quả sẽ được lưu trong profile và mở bằng DevTools
//   });
// }
