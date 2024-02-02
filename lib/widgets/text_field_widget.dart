import 'package:flutter/material.dart';
import 'package:v12_like/core/extensions/theme_extension.dart';

/// A [TextField] widget that is used to input text.
class TextFieldWidget extends StatelessWidget {
  /// This is the constructor for the text field widget.
  const TextFieldWidget({
    required this.controller,
    this.disabled = false,
    this.hint,
    super.key,
  });

  /// The controller for the text field.
  final TextEditingController controller;

  /// The hint text for the text field.
  final String? hint;

  /// Whether the text field is disabled.
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        enabled: !disabled,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: context.theme.fonts.bodyLarge?.copyWith(
            color: context.theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
