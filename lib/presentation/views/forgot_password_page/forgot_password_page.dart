import 'package:field_validators/field_validators.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({
    super.key,
    this.onSubmitted,
    this.onBackPressed,
  });

  final void Function(String email)? onSubmitted;
  final VoidCallback? onBackPressed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final data = <String, String>{
    'email': '',
  };

  void _handleRequest() async {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      //widget.onSubmitted?.call(data['email']!);
      final auth = ref.read(authProvider);
      await context.showLoadingOverlay(auth.requestPasswordReset(data['email']!));
      if (!mounted) return;
      context.popOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 16.0,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 350,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      "Password Recovery",
                      style: context.theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  AxTextInputForm(
                    labelText: "Email",
                    icon: FluentIcons.mail_16_regular,
                    required: true,
                    autofocus: true,
                    onSaved: (newValue) => data['email'] = newValue?.trim() ?? '',
                    onSubmitted: (value) => _handleRequest(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FieldValidators.compose([
                      FieldValidators.required(error: "This field is required"),
                      FieldValidators.email(error: "Invalid email address"),
                    ]),
                  ),
                  const SizedBox(height: 8.0 * 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AxButton.outline(
                        onPressed: () {
                          widget.onBackPressed?.call();
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: AxButton.primary(
                          onPressed: () => _handleRequest(),
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                "Send Recovery Email",
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
