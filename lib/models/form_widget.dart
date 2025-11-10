import 'package:flutter/material.dart';

/// Reusable form field widget: customizable title (label), hint, helper text,
/// and size (single-line or multiline via minLines/maxLines or fixed height).
class FormWidget extends StatefulWidget {
  final String title; // label/title above the field
  final String? hint; // placeholder inside the field
  final String? helperText; // small helper text under the field
  final bool requiredField; // show red * if required
  final TextEditingController? controller; // optional controller to read value
  final String? Function(String?)? validator; // optional custom validator
  final int minLines; // for multiline
  final int maxLines; // for multiline
  final double? height; // optional fixed height (overrides lines if provided)
  final TextInputType keyboardType;
  final bool? enabled;

  const FormWidget({
    super.key,
    required this.title,
    this.hint,
    this.helperText,
    this.requiredField = false,
    this.controller,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.height,
    this.keyboardType = TextInputType.text,
    this.enabled,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  // If no controller provided, create one so widget can be used standalone.
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  String? _defaultValidator(String? value) {
    if (widget.requiredField && (value == null || value.trim().isEmpty)) {
      return 'This field is required';
    }
    return null;
  }

  @override
  void dispose() {
    // Only dispose if we created the controller internally.
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build label with optional required star
    final labelRow = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        if (widget.requiredField)
          const Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
      ],
    );

    // InputDecoration shared style
    final decoration = InputDecoration(
      hintText: widget.hint,
      helperText: widget.helperText,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 14.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade700, width: 2.0),
      ),
    );

    Widget textField = TextFormField(
      controller: _controller,
      keyboardType: widget.keyboardType,
      minLines: widget.height == null ? widget.minLines : 1,
      maxLines: widget.height == null ? widget.maxLines : 1,
      decoration: decoration,
      validator: widget.validator ?? _defaultValidator,
      enabled: widget.enabled ?? true,
    );

    // If a fixed height was requested, wrap textField in a SizedBox and allow multiple lines inside with expanding behavior
    if (widget.height != null) {
      // For multiline fixed height: allow maxLines to expand visually
      textField = SizedBox(
        height: widget.height,
        child: TextFormField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          minLines: 1,
          maxLines: null, // allow lines to wrap within the given height
          decoration: decoration,
          validator: widget.validator ?? _defaultValidator,
          enabled: widget.enabled ?? true,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [labelRow, textField],
    );
  }
}
