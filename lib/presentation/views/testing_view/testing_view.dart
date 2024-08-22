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
              AxFormField(
                name: 'test2',
                builder: (field) {
                  return const AxFilePicker();
                },
                validator: FieldValidators.required(),
              ),
              AxFormField(
                name: 'test3',
                builder: (field) {
                  return const AxFilePicker(
                    multiSelect: true,
                  );
                },
                validator: FieldValidators.required(),
              ),
              Button.primary(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var data = _formKey.currentState?.save();
                    print(data);
                  }
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
