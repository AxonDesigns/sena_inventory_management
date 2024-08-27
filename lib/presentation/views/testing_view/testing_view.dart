import 'package:field_validators/field_validators.dart';
import 'package:flutter/material.dart' hide FormFieldBuilder;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class TestingView extends ConsumerStatefulWidget {
  const TestingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestingViewState();
}

class _TestingViewState extends ConsumerState<TestingView> {
  final _formKey = GlobalKey<AxFormState>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: AxForm(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AxFormField<String>(
                name: 'name',
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FieldValidators.required(),
              ),
              const SizedBox(height: 14),
              AxFormField<String>(
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
              const SizedBox(height: 14),
              AxFormField<List<String>>(
                name: 'test2',
                builder: (field) {
                  return AxFilePicker(
                    labelText: 'Images',
                    files: field.value ?? [],
                    onChanged: (files) {
                      field.didChange(files);
                    },
                  );
                },
              ),
              const SizedBox(height: 14),
              AxFormField<List<String>>(
                name: 'list_of_images',
                initialValue: const ["C:/Users/AxonStudios/Downloads/_adb4dba5-10e8-4510-a0dc-6673a1dd7188.jpeg"],
                builder: (field) {
                  return AxFilePicker(
                    labelText: 'Images',
                    multiSelect: true,
                    files: field.value ?? [],
                    onChanged: (files) {
                      field.didChange(files);
                    },
                  );
                },
              ),
              const SizedBox(height: 14),
              AxPicker(),
              const SizedBox(height: 14),
              Button.primary(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                tooltip: "Save",
                children: const [Text("Save")],
              )
            ],
          ),
        ),
      ),
    );
  }
}
