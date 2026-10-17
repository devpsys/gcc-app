import 'package:flutter/material.dart';

import 'package:gcc_app/features/agent_capture/presentation/bloc/media_pipeline.dart';

import 'compression_sheet.dart';

/// Route-level entry for the media pipeline.
///
/// The pipeline is a sheet rather than a page, so this wraps it in a screen of
/// its own — which also keeps it reachable by deep link.
class CompressionRoutePage extends StatelessWidget {
  const CompressionRoutePage({this.stage, super.key});

  final MediaPipelineStage? stage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CompressionSheet(stage: stage ?? MediaPipelineStage.compressing),
      ),
    );
  }
}
