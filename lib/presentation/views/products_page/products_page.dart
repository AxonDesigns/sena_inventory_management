import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/models/product.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  late final _products = ref.read(productRepositoryProvider).getAll();
  final _formatter = CurrencyTextInputFormatter.currency(locale: 'es_CO', decimalDigits: 2, name: 'COP');

  final int _pageSize = 10;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return _products.buildWidget(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Products', style: context.theme.textTheme.titleSmall),
                      const Spacer(),
                      Button.outline(onPressed: () {}, children: const [Icon(FluentIcons.arrow_up_12_regular), Text('Export')]),
                      const SizedBox(width: 10),
                      Button.outline(onPressed: () {}, children: const [Icon(FluentIcons.arrow_down_12_regular), Text('Import')]),
                      const SizedBox(width: 10),
                      Button.primary(onPressed: () {}, children: const [Icon(FluentIcons.add_12_regular), Text('New')]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colorScheme.surfaceContainerHigh, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DataTable2(
                    showCheckboxColumn: true,
                    headingRowColor: WidgetStatePropertyAll(context.colorScheme.surfaceContainerHigh),
                    headingRowHeight: 40,
                    columns: [
                      DataColumn2(
                        label: Text('Name', style: context.theme.textTheme.bodyMedium),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Description', style: context.theme.textTheme.bodyMedium),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text(
                          'Price',
                          style: context.theme.textTheme.bodyMedium,
                          softWrap: false,
                        ),
                        numeric: true,
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Unit', style: context.theme.textTheme.bodyMedium),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Created', style: context.theme.textTheme.bodyMedium),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: Text('Updated', style: context.theme.textTheme.bodyMedium),
                        size: ColumnSize.M,
                      ),
                      DataColumn2(
                        label: Text('', style: context.theme.textTheme.bodyMedium),
                        fixedWidth: 150,
                        size: ColumnSize.S,
                      ),
                    ],
                    rows: data.indexed.map(
                      (item) {
                        final product = item.$2;
                        final index = item.$1;
                        return DataRow(
                          color: WidgetStatePropertyAll(context.colorScheme.surfaceContainerLow.withOpacity(index % 2 == 0 ? 0.5 : 1.0)),
                          cells: [
                            DataCell(Text(product.name)),
                            DataCell(Text(product.description)),
                            DataCell(Text(_formatter.formatDouble(product.price))),
                            DataCell(Text('${product.unit.name} (${product.unit.symbol})')),
                            DataCell(Text(_formatDate(product.created))),
                            DataCell(Text(_formatDate(product.updated))),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Button.glass(
                                    onPressed: () {},
                                    children: const [Icon(FluentIcons.edit_12_filled)],
                                  ),
                                  const SizedBox(width: 10),
                                  Button.custom(
                                    backgroundColor: context.colorScheme.error,
                                    foregroundColor: context.colorScheme.onError,
                                    onPressed: () {},
                                    children: const [Icon(FluentIcons.delete_12_filled)],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button.ghost(
                    onPressed: _page == 0 ? null : () {},
                    children: const [Icon(FluentIcons.chevron_left_12_filled)],
                  ),
                  const SizedBox(width: 10),
                  Text('$_page - $_pageSize of ${data.length}'),
                  const SizedBox(width: 10),
                  Button.ghost(
                    onPressed: _page == data.length ? null : () {},
                    children: const [Icon(FluentIcons.chevron_right_12_filled)],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stackTrace) => Text(err.toString()),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year} | ${date.hour}:${date.minute}:${date.second}';

  Container _buildProductTile(BuildContext context, Product product) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: product.urls.isNotEmpty ? NetworkImage(product.urls[0]) : null,
              radius: 15,
              child: product.urls.isEmpty ? const Icon(FluentIcons.image_16_filled, size: 15) : null,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontVariations: [FontVariation('wght', 420)],
                  ),
                ),
                Text(
                  _formatter.formatDouble(product.price),
                  style: context.theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 11,
                    fontVariations: const [FontVariation('wght', 250)],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Text(
              _formatter.formatDouble(product.price),
              style: context.theme.textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontVariations: const [FontVariation('wght', 250)],
              ),
            ),
            /*Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(product.state.name),
              ),
            ),*/
            const SizedBox(width: 10),
            const Spacer(),
            Button.glass(
              onPressed: () {},
              children: const [Icon(FluentIcons.edit_12_filled)],
            ),
            const SizedBox(width: 10),
            Button.glass(
              onPressed: () {},
              children: const [Icon(FluentIcons.delete_12_filled)],
            ),
          ],
        ),
      ),
    );
  }
}
