import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class EmployeesPage extends ConsumerStatefulWidget {
  const EmployeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends ConsumerState<EmployeesPage> {
  late final _employees = ref.read(userRepositoryProvider).getAllEmployees();

  @override
  Widget build(BuildContext context) {
    return _employees.buildWidget(
      data: (data) {
        print(data);
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(data[index].fullName),
            subtitle: Text(data[index].email),
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
