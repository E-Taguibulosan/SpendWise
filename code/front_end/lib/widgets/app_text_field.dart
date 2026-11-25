import 'package:material_ui/material_ui.dart';
import '../theme/app_theme.dart';

/// Reusable text field for SpendWise.
/// - Shows a label above the field
/// - Shows helper text under the field
/// - On error, shows an ICON + red text (not color alone)
class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String value) validator;
  final bool obscureText;
  final Widget? suffix;
  final String? helper;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    this.suffix,
    this.helper,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => validator(controller.text),
      builder: (state) {
        final hasError = state.hasError;
        final borderColor = hasError ? AppColors.error : AppColors.border;

        OutlineInputBorder border(Color color, [double width = 1]) {
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: color, width: width),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              // Re-check as the user types, once an error is showing
              onChanged: (_) {
                if (state.hasError) state.validate();
              },
              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: suffix,
                enabledBorder: border(borderColor),
                focusedBorder: border(
                  hasError ? AppColors.error : AppColors.primary,
                  2,
                ),
              ),
            ),
            const SizedBox(height: 4),
            if (hasError)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline,
                      size: 16, color: AppColors.error),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.error),
                    ),
                  ),
                ],
              )
            else if (helper != null)
              Text(
                helper!,
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary),
              ),
          ],
        );
      },
    );
  }
}