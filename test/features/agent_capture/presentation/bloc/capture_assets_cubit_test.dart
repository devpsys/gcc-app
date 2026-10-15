import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_availability.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_category.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_condition_grade.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';

import '../../fake_capture_gateway.dart';

void main() {
  late CaptureCubit cubit;

  setUp(() => cubit = CaptureCubit(FakeCaptureGateway()));
  tearDown(() => cubit.close());

  void fillCurrent() {
    cubit
      ..selectAssetCategory(AssetCategory.generators)
      ..editAssetCapacity('100 kVA')
      ..selectAssetCondition(AssetConditionGrade.good)
      ..selectAssetAvailability(AssetAvailability.rentalOnly);
  }

  group('location step', () {
    test('a landmark is the only requirement the step enforces', () {
      expect(cubit.draft.landmark.trim(), isEmpty);
      cubit.editLandmark('beside the main gate');
      expect(cubit.draft.landmark, 'beside the main gate');
    });
  });

  group('asset step', () {
    test('the form starts closed so the empty state shows', () {
      expect(cubit.draft.showAssetForm, isFalse);
      expect(cubit.draft.asset.isEmpty, isTrue);
      cubit.startAssetForm();
      expect(cubit.draft.showAssetForm, isTrue);
    });

    test('an empty asset is not complete', () {
      expect(cubit.draft.asset.isComplete, isFalse);
      expect(cubit.draft.asset.issueCount, 3);
    });

    test('category, capacity and condition are what make it complete', () {
      cubit.selectAssetCategory(AssetCategory.generators);
      expect(cubit.draft.asset.isComplete, isFalse);
      cubit.editAssetCapacity('100 kVA');
      expect(cubit.draft.asset.isComplete, isFalse);
      cubit.selectAssetCondition(AssetConditionGrade.good);
      expect(cubit.draft.asset.isComplete, isTrue);
      expect(cubit.draft.asset.issueCount, 0);
    });

    test('appending an incomplete asset fails and flags the attempt', () {
      cubit.startAssetForm();
      expect(cubit.addAsset(), isFalse);
      expect(cubit.draft.assetAttempted, isTrue);
      expect(cubit.draft.assets, isEmpty);
    });

    test('appending a complete asset numbers it and resets the form', () {
      cubit.startAssetForm();
      fillCurrent();
      expect(cubit.addAsset(), isTrue);

      expect(cubit.draft.assets, hasLength(1));
      expect(cubit.draft.assets.single.displayReference, 'AST-0912');
      expect(cubit.draft.asset.isEmpty, isTrue);
      expect(cubit.draft.assetAttempted, isFalse);
      expect(
        cubit.draft.showAssetForm,
        isTrue,
        reason: 'stays open for the next one',
      );
    });

    test('references stay stable as assets accumulate', () {
      cubit.startAssetForm();
      fillCurrent();
      cubit.addAsset();
      fillCurrent();
      cubit.addAsset();

      expect(cubit.draft.assets.map((asset) => asset.displayReference), [
        'AST-0912',
        'AST-0913',
      ]);
    });

    test('removing an asset leaves the others unchanged', () {
      cubit.startAssetForm();
      fillCurrent();
      cubit.addAsset();
      fillCurrent();
      cubit.addAsset();

      final first = cubit.draft.assets.first;
      cubit.removeAssetAt(0);

      expect(cubit.draft.assets, hasLength(1));
      expect(cubit.draft.assets.single.displayReference, 'AST-0913');
      expect(first.displayReference, 'AST-0912');
    });

    test('removing an out-of-range asset is a no-op', () {
      cubit.removeAssetAt(4);
      cubit.removeAssetAt(-1);
      expect(cubit.draft.assets, isEmpty);
    });

    test('quantity never falls below one', () {
      cubit.changeAssetQuantity(-1);
      expect(cubit.draft.asset.quantity, 1);

      cubit.changeAssetQuantity(3);
      expect(cubit.draft.asset.quantity, 4);
    });

    test('availability is optional and independent of completeness', () {
      cubit.startAssetForm();
      fillCurrent();
      expect(cubit.draft.asset.availability, AssetAvailability.rentalOnly);
      expect(cubit.draft.asset.isComplete, isTrue);
    });
  });
}
