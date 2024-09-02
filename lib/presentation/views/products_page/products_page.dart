import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/models/product.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';
import 'package:sena_inventory_management/presentation/views/products_page/product_creation.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  late final List<bool> _selected;
  late final _products = ref.read(productRepositoryProvider).getAll()
    ..then((value) {
      _selected = List.generate(value.length, (index) => false);
    });

  final int _pageSize = 10;
  // ignore: prefer_final_fields
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return _products.buildWidget(
      data: (data) {
        final checkboxTheme = CheckboxThemeData(
          fillColor: WidgetStatePropertyAll(context.colorScheme.surfaceContainerHighest),
          checkColor: WidgetStatePropertyAll(context.colorScheme.primary),
          overlayColor: WidgetStatePropertyAll(context.colorScheme.surfaceContainer),
          side: BorderSide(color: context.colorScheme.primary, width: 2),
        );
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
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.fastEaseInToSlowEaseOut,
                        switchOutCurve: Curves.fastEaseInToSlowEaseOut,
                        transitionBuilder: (child, animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: _selected.contains(true)
                            ? Text(
                                'Selected (${_selected.where(
                                      (element) => element,
                                    ).length})',
                                style: context.theme.textTheme.titleSmall)
                            : Text('Products', style: context.theme.textTheme.titleSmall),
                      ),
                      const Spacer(),
                      Button.outline(onPressed: () {}, children: const [Icon(FluentIcons.arrow_up_12_regular), Text('Export')]),
                      const SizedBox(width: 10),
                      Button.outline(onPressed: () {}, children: const [Icon(FluentIcons.arrow_down_12_regular), Text('Import')]),
                      const SizedBox(width: 10),
                      Button.primary(
                          onPressed: () {
                            _handleNew(context);
                          },
                          children: const [Icon(FluentIcons.add_12_regular), Text('New')]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: AxTextInput(
                          prefix: const Icon(FluentIcons.search_24_regular),
                          hintText: 'Search',
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 14),
                      Button.secondary(
                        onPressed: () {},
                        children: const [Icon(FluentIcons.filter_24_regular)],
                      ),
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
                  child: RepaintBoundary(
                    child: DataTable2(
                      showCheckboxColumn: true,
                      headingRowColor: WidgetStatePropertyAll(context.colorScheme.surfaceContainerHigh),
                      headingRowHeight: 40,
                      datarowCheckboxTheme: checkboxTheme,
                      headingCheckboxTheme: checkboxTheme,
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
                            selected: _selected[index],
                            onSelectChanged: (value) {
                              setState(() => _selected[index] = value ?? false);
                            },
                            color: WidgetStatePropertyAll(context.colorScheme.surfaceContainerLow.withOpacity(index % 2 == 0 ? 0.5 : 1.0)),
                            cells: [
                              DataCell(Text(product.name)),
                              DataCell(Text(
                                product.description.isEmpty ? 'No description' : product.description,
                                style: product.description.isEmpty ? TextStyle(color: context.colorScheme.onSurface.withOpacity(0.5)) : null,
                              )),
                              DataCell(Text(currencyFormatter.formatDouble(product.price))),
                              DataCell(Text('${product.unit.name} (${product.unit.symbol})')),
                              DataCell(Text(formatDate(product.created))),
                              DataCell(Text(formatDate(product.updated))),
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Button.glass(
                                      onPressed: () {
                                        _handleEdit(context, product);
                                      },
                                      children: const [Icon(FluentIcons.edit_12_filled)],
                                    ),
                                    const SizedBox(width: 10),
                                    Button.custom(
                                      backgroundColor: context.colorScheme.error,
                                      foregroundColor: context.colorScheme.onError,
                                      onPressed: () {
                                        _handleDelete(context, product);
                                      },
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

  Future<bool> _handleDelete(BuildContext context, Product product) async {
    final result = await context.showOverlay<bool>(
      builder: (context, content, alpha) {
        return Center(
          child: Opacity(
            opacity: alpha,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Delete Product',
                      style: context.theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Are you sure you want to delete this product?',
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button.ghost(
                          onPressed: () => context.popOverlay(false),
                          children: const [Text('Cancel')],
                        ),
                        const SizedBox(width: 10),
                        Button.primary(
                          onPressed: () => context.popOverlay(true),
                          children: const [Text('Delete')],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return result ?? false;
  }

  Future<Product?> _handleNew(BuildContext context) async {
    var result = context.showOverlay<Product?>(
      builder: (context, content, alpha) {
        return Transform.translate(
          offset: Offset(alpha.lerp(25, 0.0), 0.0),
          child: Opacity(opacity: alpha, child: content),
        );
      },
      child: const ProductCreation(),
    );
    return result;
  }

  Future<Product?> _handleEdit(BuildContext context, Product product) async {
    var result = context.showOverlay<Product?>(
      builder: (context, content, alpha) {
        return Transform.translate(
          offset: Offset(alpha.lerp(25, 0.0), 0.0),
          child: Opacity(opacity: alpha, child: content),
        );
      },
      child: ProductCreation(product: product),
    );
    return result;
  }
}
