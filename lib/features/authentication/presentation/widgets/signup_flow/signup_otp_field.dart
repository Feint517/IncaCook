import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

/// 6-box one-time-password input.
///
/// Backed by [Pinput] — one hidden text field drives all six visible
/// cells, which means the system keyboard never has to switch focus
/// between sibling fields. The previous "6 separate `TextField`s" version
/// flickered the iOS keyboard on every digit and occasionally stranded
/// it on screen after completion; the single-field approach avoids both
/// issues.
///
/// Public API ([onCompleted], [onChanged], [errorText], [length]) is
/// unchanged so callers don't need updates.
class SignupOtpField extends StatefulWidget {
  const SignupOtpField({
    super.key,
    required this.onCompleted,
    this.length = 6,
    this.onChanged,
    this.errorText,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;
  final String? errorText;

  @override
  State<SignupOtpField> createState() => _SignupOtpFieldState();
}

class _SignupOtpFieldState extends State<SignupOtpField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleCompleted(String code) {
    // Drop the keyboard before handing off — otherwise the page transition
    // that fires inside onCompleted (the wizard advances) can leave the
    // numpad floating over the next screen on iOS.
    _focusNode.unfocus();
    widget.onCompleted(code);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    final defaultTheme = PinTheme(
      width: 48,
      height: 56,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent, width: 1.5),
      ),
    );

    return Column(
      children: [
        Pinput(
          controller: _controller,
          focusNode: _focusNode,
          length: widget.length,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          defaultPinTheme: defaultTheme,
          focusedPinTheme: defaultTheme.copyDecorationWith(
            border: Border.all(
              color: hasError ? scheme.error : scheme.primary,
              width: 1.5,
            ),
          ),
          errorPinTheme: defaultTheme.copyDecorationWith(
            border: Border.all(color: scheme.error, width: 1.5),
          ),
          forceErrorState: hasError,
          onChanged: widget.onChanged,
          onCompleted: _handleCompleted,
        ),
        if (hasError) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
          ),
        ],
      ],
    );
  }
}
