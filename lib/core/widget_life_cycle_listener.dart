import 'package:flutter/material.dart';

class WidgetLifecycleListener extends StatefulWidget {
  const WidgetLifecycleListener({
    super.key,
    this.onInit,
    this.onDispose,
    this.child,
  })  : isSliver = false;

  const WidgetLifecycleListener.sliver({
    super.key,
    this.onInit,
    this.onDispose,
    this.child,
  })  : isSliver = true;

  const WidgetLifecycleListener.custom({
    super.key,
    this.onInit,
    this.onDispose,
    this.child,
    required this.isSliver,
  });

  final VoidCallback? onInit;
  final VoidCallback? onDispose;
  final Widget? child;
  final bool isSliver;

  @override
  State<WidgetLifecycleListener> createState() =>
      _WidgetLifecycleListenerState();
}

class _WidgetLifecycleListenerState extends State<WidgetLifecycleListener> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;
    if (child != null) {
      return child;
    } else {
      if (widget.isSliver) {
        return SliverPadding(
          padding: EdgeInsets.zero,
          sliver: widget.child,
        );
      } else {
        return SizedBox(
          child: widget.child,
        );
      }
    }
  }
}
