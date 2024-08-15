import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';

class TransactionStatusChip extends ConsumerWidget {
  const TransactionStatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: switch (status) {
          'Pending' => context.colorScheme.surfaceContainerHighest,
          'Completed' => context.colorScheme.primaryContainer,
          'Cancelled' => context.colorScheme.errorContainer,
          'Inactive' => context.colorScheme.surfaceContainerHigh,
          _ => context.colorScheme.surfaceContainerHighest,
        },
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          status,
          style: context.theme.textTheme.bodyMedium!.copyWith(
            color: context.colorScheme.onSurface.withOpacity(
              switch (status) {
                'Inactive' => 0.5,
                _ => 1.0,
              },
            ),
          ),
        ),
      ),
    );
  }
}
