import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool loading;
  final Widget child;

  const LoadingView({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return child;
  }
}