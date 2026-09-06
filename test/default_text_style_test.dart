import 'package:dh_dialog/dh_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('title and content preserve ambient font family', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'BrandFont'),
        home: Scaffold(
          body: DHDialog(
            title: const Text('Title'),
            content: const Text('Content'),
          ),
        ),
      ),
    );

    final titleStyle = _effectiveStyleOf(tester, 'Title');
    final contentStyle = _effectiveStyleOf(tester, 'Content');

    expect(titleStyle.fontFamily, 'BrandFont');
    expect(titleStyle.fontSize, 16);
    expect(contentStyle.fontFamily, 'BrandFont');
    expect(contentStyle.fontSize, 14);
  });

  testWidgets('custom styles preserve unspecified ambient properties', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'BrandFont'),
        home: Scaffold(
          body: DHDialog(
            titleTextStyle: const TextStyle(fontSize: 20),
            contentTextStyle: const TextStyle(color: Colors.red),
            title: const Text('Title'),
            content: const Text('Content'),
          ),
        ),
      ),
    );

    final titleStyle = _effectiveStyleOf(tester, 'Title');
    final contentStyle = _effectiveStyleOf(tester, 'Content');

    expect(titleStyle.fontFamily, 'BrandFont');
    expect(titleStyle.fontSize, 20);
    expect(contentStyle.fontFamily, 'BrandFont');
    expect(contentStyle.color, Colors.red);
  });

  testWidgets('explicit font family overrides the ambient font', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(fontFamily: 'BrandFont'),
        home: Scaffold(
          body: DHDialog(
            titleTextStyle: const TextStyle(fontFamily: 'DialogFont'),
            contentTextStyle: const TextStyle(
              fontFamily: 'IsolatedFont',
              inherit: false,
            ),
            title: const Text('Title'),
            content: const Text('Content'),
          ),
        ),
      ),
    );

    expect(_effectiveStyleOf(tester, 'Title').fontFamily, 'DialogFont');
    expect(_effectiveStyleOf(tester, 'Content').fontFamily, 'IsolatedFont');
  });
}

TextStyle _effectiveStyleOf(WidgetTester tester, String text) {
  final element = tester.element(find.text(text));
  return DefaultTextStyle.of(element).style.merge(
        tester.widget<Text>(find.text(text)).style,
      );
}
