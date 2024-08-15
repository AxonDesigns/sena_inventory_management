import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/views/transactions_page/transaction_info.dart';
import 'package:sena_inventory_management/presentation/views/transactions_page/transaction_status_chip.dart';

class TransactionCard extends ConsumerStatefulWidget {
  const TransactionCard({super.key, required this.transaction});

  final Transaction transaction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionCardState();
}

class _TransactionCardState extends ConsumerState<TransactionCard> {
  var _hovered = false;
  //var _pressed = false;

  void _handleTap() {
    context.showOverlay(
      builder: (context, content, alpha) {
        return Transform.translate(
          offset: Offset(0, alpha.lerp(15.0, 0.0)),
          child: Opacity(
            opacity: alpha,
            child: content,
          ),
        );
      },
      child: TransactionInfo(alpha: 1.0, transaction: widget.transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowHoverHighlight: (value) {
          setState(() => _hovered = value);
        },
        child: GestureDetector(
          onTap: _handleTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastEaseInToSlowEaseOut,
            height: 107,
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer.withOpacity(_hovered ? 1.0 : 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.transaction.type,
                              style: context.theme.textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 10),
                            TransactionStatusChip(status: widget.transaction.status),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(widget.transaction.responsable.fullName, style: context.theme.textTheme.bodyMedium),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(widget.transaction.source.name, style: context.theme.textTheme.bodyMedium),
                            const SizedBox(width: 10),
                            const Icon(FluentIcons.chevron_right_12_regular),
                            const SizedBox(width: 10),
                            Text(widget.transaction.destination.name, style: context.theme.textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.transaction.productTransactions.fold(0.0, (previousValue, element) => previousValue + element.amount).toInt()} products',
                        style: context.theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: Icon(FluentIcons.chevron_right_12_regular),
                      ),
                      Text(
                        formatDate(widget.transaction.updated),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
