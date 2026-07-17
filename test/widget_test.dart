import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bytemail/app.dart';

void main() {
  testWidgets('ByteMail shell renders Unified Inbox', (tester) async {
    final view = tester.view;
    view.physicalSize = const Size(1400, 900);
    view.devicePixelRatio = 1.0;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);

    await tester.pumpWidget(const ByteMailApp());
    await tester.pump();

    expect(find.text('ByteMail'), findsOneWidget);
    expect(find.textContaining('Unified'), findsWidgets);
    expect(find.text('Maya Chen'), findsOneWidget);
  });
}
