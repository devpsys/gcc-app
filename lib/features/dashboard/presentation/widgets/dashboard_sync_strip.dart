import 'package:flutter/material.dart';
import 'package:gcc_app/core/widgets/sync_status_banner.dart';

class DashboardSyncStrip extends StatefulWidget {
  const DashboardSyncStrip({
    required this.kind,
    required this.message,
    this.detail,
    this.disabledReason,
    this.onPressed,
    super.key,
  });

  final SyncBannerKind kind;
  final String message;
  final String? detail;
  final String? disabledReason;
  final VoidCallback? onPressed;

  @override
  State<DashboardSyncStrip> createState() => _DashboardSyncStripState();
}

class _DashboardSyncStripState extends State<DashboardSyncStrip> {
  SyncBannerKind? _announced;

  @override
  Widget build(BuildContext context) {
    final announce = _announced != widget.kind;
    if (announce) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _announced != widget.kind) {
          setState(() => _announced = widget.kind);
        }
      });
    }
    final banner = Semantics(
      button: widget.onPressed != null,
      liveRegion: announce,
      child: SyncStatusBanner(
        kind: widget.kind,
        message: widget.message,
        detail: widget.detail,
        inline: true,
      ),
    );
    final open = widget.onPressed;
    if (open != null) {
      return InkWell(onTap: open, child: banner);
    }
    final reason = widget.disabledReason;
    if (reason == null) {
      return banner;
    }
    return Tooltip(message: reason, child: banner);
  }
}
