import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/field_map_screen.dart';

/// Binds [FieldMapScreen] to the map cubit the route provides.
class FieldMapLoader extends StatelessWidget {
  const FieldMapLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return switch (state) {
          MapReady(:final view, :final roadLabels) => FieldMapScreen(
            shops: view.shops,
            roadLabels: roadLabels,
          ),
          _ => const FieldMapScreen(),
        };
      },
    );
  }
}
