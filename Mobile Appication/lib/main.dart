import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:student_chatbot/pages/home_page.dart';
import 'package:student_chatbot/pages/login_page.dart';
import 'package:student_chatbot/pages/signup_page.dart';

void main() {
  final coldStartWatch = Stopwatch()..start();
  Timeline.startSync('App#startup');

  WidgetsFlutterBinding.ensureInitialized();

  // Biến tính toán
  int   frameCount  = 0;
  int   slowFrames  = 0;
  Duration uiSum    = Duration.zero;
  Duration rasterSum= Duration.zero;

  WidgetsBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
    for (final t in timings) {
      frameCount++;
      uiSum     += t.buildDuration;
      rasterSum += t.rasterDuration;
      // totalSpan = build + raster
      if (t.totalSpan.inMilliseconds > 16) {
        slowFrames++;
      }
    }

    if (frameCount >= 60) {
      final avgUi     = uiSum.inMilliseconds   / frameCount;
      final avgRaster = rasterSum.inMilliseconds / frameCount;
      final pctJank   = slowFrames / frameCount * 100;

      debugPrint('📊 Avg frame time (UI):    ${avgUi.toStringAsFixed(1)} ms');
      debugPrint('📊 Avg frame time (Raster): ${avgRaster.toStringAsFixed(1)} ms');
      debugPrint('🐢 Slow frames: $slowFrames / $frameCount (${pctJank.toStringAsFixed(1)}%)');

      // reset cho lần đo tiếp theo
      frameCount = slowFrames = 0;
      uiSum = rasterSum = Duration.zero;
    }
  });

  runApp(MyApp(coldStartWatch: coldStartWatch));
}

class MyApp extends StatelessWidget {
  final Stopwatch coldStartWatch;
  const MyApp({super.key, required this.coldStartWatch});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      coldStartWatch.stop();
      Timeline.finishSync();
      debugPrint('🍀 Cold‑start TotalTime:    ${coldStartWatch.elapsedMilliseconds} ms');
      debugPrint('🎞️ First‑frame render time: ${coldStartWatch.elapsedMilliseconds} ms');
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => const LoginPage(),
        '/signup': (ctx) => const SignupPage(),
        '/home': (ctx) => const HomePage(),
      },
      showPerformanceOverlay: true,
    );
  }
}
