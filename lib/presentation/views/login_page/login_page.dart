import 'package:field_validators/field_validators.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final data = <String, String>{
    'email': '',
    'password': '',
  };

  void _handleSignIn() async {
    final auth = ref.read(authProvider);

    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      final future = auth.signIn(email: data['email']!, password: data['password']!);
      final result = await context.showLoadingOverlay(future);
      if (result != null && result.isSuccess) {
        final router = ref.watch(appRouterProvider);
        router.go(homeRoute);
      } else {
        if (!mounted) return;
        context.showOverlay(
          builder: (context, child, alpha) {
            final message = result!.error!.response['message'] ?? "Invalid credentials";
            return Opacity(
              opacity: alpha,
              child: Center(
                child: SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.headlineSmall!.copyWith(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8.0),
                      Button.primary(
                        onPressed: () => context.popOverlay(),
                        children: const [
                          Text("Accept"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    }
  }

  void _handleForgotPassword() async {
    if (!mounted) return;
    context.showOverlay(
      builder: (context, content, alpha) {
        return Opacity(
          opacity: alpha,
          child: Transform.translate(
            offset: Offset(0.0, alpha.remap(0, 1, 50.0, 0)),
            child: Center(child: content),
          ),
        );
      },
      child: ForgotPasswordPage(
        onSubmitted: (email) => context.popOverlay(),
        onBackPressed: () => context.popOverlay(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
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
                    "Sign In",
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
                  onSubmitted: (value) => _handleSignIn(),
                  validator: FieldValidators.compose([
                    FieldValidators.required(error: "This field is required"),
                    FieldValidators.email(error: "Invalid email address"),
                  ]),
                ),
                const SizedBox(height: 8.0),
                AxTextInputForm(
                  labelText: "Password",
                  icon: FluentIcons.lock_closed_16_regular,
                  required: true,
                  obscureText: true,
                  onSaved: (newValue) => data['password'] = newValue?.trim() ?? '',
                  onSubmitted: (value) => _handleSignIn(),
                  showToggleObscureButton: true,
                  validator: FieldValidators.compose([
                    FieldValidators.required(error: "This field is required"),
                  ]),
                ),
                const SizedBox(height: 4.0),
                Link(
                  child: const Text("Forgot Password?"),
                  onPressed: () => _handleForgotPassword(),
                ),
                const SizedBox(height: 8.0 * 4.0),
                Button.primary(
                  onPressed: () => _handleSignIn(),
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "Let's Go",
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
