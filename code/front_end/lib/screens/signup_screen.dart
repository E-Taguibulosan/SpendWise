import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';
import '../widgets/app_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ----- Validators (return an error message, or null if OK) -----
  String? _validateName(String value) {
    if (value.trim().isEmpty) return 'Name is required';
    return null;
  }

  String? _validateEmail(String value) {
    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.length < 6) return 'Password must be at least 6 characters';
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'\d').hasMatch(value);
    if (!hasLetter || !hasNumber) {
      return 'Password must have a letter and a number';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO (Backend dev): save the new user to the database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );
      // TODO (Navigation dev): go to the Dashboard screen.
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
                Text('A fresh start for your finances.',
                    style: textTheme.headlineMedium),
                const SizedBox(height: AppSpacing.xs),
                Text('Track every peso. Stay on budget.',
                    style: textTheme.bodyMedium),
                const SizedBox(height: AppSpacing.md),

                AppTextField(
                  label: 'Name or username',
                  hint: 'What should we call you?',
                  controller: _nameController,
                  validator: _validateName,
                ),
                const SizedBox(height: AppSpacing.sm),

                AppTextField(
                  label: 'Email address',
                  hint: 'you@gmail.com',
                  helper: 'Gmail or any email address you use.',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.sm),

                AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  helper: 'At least 6 characters, with a letter and a number',
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
                  child: const Text('Sign up'),
                ),
                const SizedBox(height: AppSpacing.sm),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?',
                        style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Text('Log in'),
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