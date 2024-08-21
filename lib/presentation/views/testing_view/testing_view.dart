import 'package:field_validators/field_validators.dart';
import 'package:flutter/material.dart' hide FormFieldBuilder;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/components/form_builder.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class TestingView extends ConsumerStatefulWidget {
  const TestingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestingViewState();
}

class _TestingViewState extends ConsumerState<TestingView> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormFieldBuilder<String>(
              name: 'name',
              builder: (field) {
                return TextField(
                  onChanged: (value) {
                    field.didChange(value);
                  },
                );
              },
            ),
            FormFieldBuilder<String>(
              name: 'test',
              builder: (field) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        field.didChange(value);
                      },
                    ),
                    if (field.error != null) Text(field.error!),
                  ],
                );
              },
              validator: FieldValidators.required(),
            ),
            Button.primary(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var data = _formKey.currentState?.getData();
                  print(data);
                }
              },
              tooltip: "Save",
              children: const [Text("Save")],
            )
          ],
        ),
      ),
    );
  }
}
