import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  bool _loginFailed = false;

  // TEMPORARY dummy account (Backend dev will replace this with the database)
  static const _dummyEmail = 'efren@gmail.com';
  static const _dummyPassword = 'efren123';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String value) {
    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Enter your password';
    return null;
  }

  void _submit() {
    setState(() => _loginFailed = false);

    if (!_formKey.currentState!.validate()) return;

    final emailOk = _emailController.text.trim().toLowerCase() == _dummyEmail;
    final passwordOk = _passwordController.text == _dummyPassword;

    if (emailOk && passwordOk) {
      // TODO (Navigation dev): go to the Dashboard screen.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Welcome back, Efren!')),
      );
    } else {
      setState(() => _loginFailed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Welcome back', style: textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('Log in to see your spending.',
                    style: textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.md),

                // Error banner: icon + text (not color alone)
                if (_loginFailed) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBEAEA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.error),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.error_outline, color: AppColors.error),
                        SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            'Incorrect email or password',
                            style: TextStyle(color: AppColors.error),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],

                AppTextField(
                  label: 'Email address',
                  hint: 'you@gmail.com',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.sm),

                AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  validator: _validatePassword,
                  suffix: IconButton(
                    tooltip: _hidePassword ? 'Show password' : 'Hide password',
                    icon: Icon(_hidePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () =>
                        setState(() => _hidePassword = !_hidePassword),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Log in'),
                ),
                const SizedBox(height: AppSpacing.sm),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No account yet?',
                        style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignUpScreen()),
                        );
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}