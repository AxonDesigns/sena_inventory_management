import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class EmployeesPage extends ConsumerStatefulWidget {
  const EmployeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends ConsumerState<EmployeesPage> {
  @override
  Widget build(BuildContext context) {
    final employees = ref.watch(userRepositoryProvider).getAllEmployees();
    return employees.buildWidget(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
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
                      Text('Employees', style: context.theme.textTheme.titleSmall),
                      const Spacer(),
                      Button.outline(
                          onPressed: () {
                            setState(() {
                              ref.invalidate(userRepositoryProvider);
                            });
                          },
                          tooltip: 'Refresh',
                          children: const [Icon(FluentIcons.arrow_sync_12_regular)]),
                      const SizedBox(width: 10),
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
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final employee = data[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            if (employee.avatarPath != null)
                              CircleAvatar(
                                backgroundImage: NetworkImage(employee.avatarPath!),
                                radius: 20,
                              ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(employee.fullName, style: context.theme.textTheme.bodyLarge),
                                const SizedBox(height: 4),
                                Text(employee.email,
                                    style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.onSurface.withOpacity(0.5))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return const Center(child: Text("Error"));
      },
    );
  }
}
