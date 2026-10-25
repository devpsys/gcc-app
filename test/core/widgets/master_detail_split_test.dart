import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/widgets/master_detail_split.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows only the master pane on a phone', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(390, 844),
      child: const MasterDetailSplit(
        master: Text('master'),
        detail: Text('detail'),
      ),
    );

    expect(find.text('master'), findsOneWidget);
    expect(find.text('detail'), findsNothing);
  });

  testWidgets('splits master and detail on tablet', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(768, 1024),
      child: const MasterDetailSplit(
        master: Text('master'),
        detail: Text('detail'),
      ),
    );

    expect(find.text('master'), findsOneWidget);
    expect(find.text('detail'), findsOneWidget);
  });
}
