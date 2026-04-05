import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';

import 'package:fvm_example/main.dart';
import 'package:fvm_example/widgets/weather_background.dart';

void main() {
  group('HomePage', () {
    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(const MainApp());
      await tester.pump();
    }

    testWidgets('should display LottieBuilder on initial load',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(LottieBuilder), findsOneWidget);
    });

    testWidgets('should show sunny title and icon initially', (tester) async {
      await pumpApp(tester);
      expect(find.text('Sunny Day'), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    });

    testWidgets('should switch to rainy after toggle tap', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.byTooltip('Toggle weather'));
      await tester.pump();

      expect(find.text('Rainy Day'), findsOneWidget);
      expect(find.byIcon(Icons.grain), findsOneWidget);
    });

    testWidgets('should contain WeatherBackground', (tester) async {
      await pumpApp(tester);
      expect(find.byType(WeatherBackground), findsOneWidget);
    });
  });

  group('WeatherBackground', () {
    Widget buildSubject({Weather weather = Weather.sunny}) {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox.expand(
            child: WeatherBackground(weather: weather),
          ),
        ),
      );
    }

    testWidgets('should render CustomPaint for particles', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('should have AnimatedContainer for gradient', (tester) async {
      await tester.pumpWidget(buildSubject());
      await tester.pump();
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });

    testWidgets('should repaint after pumping frames without errors',
        (tester) async {
      await tester.pumpWidget(buildSubject());

      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      expect(find.byType(CustomPaint), findsWidgets);
      expect(find.byType(AnimatedContainer), findsOneWidget);
    });
  });
}
