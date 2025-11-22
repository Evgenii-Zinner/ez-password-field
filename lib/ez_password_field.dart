import 'package:flutter/material.dart';

/// A highly customizable password field with built-in validation and visibility toggle.
class EzPasswordField extends StatefulWidget {
  /// The controller for the text field.
  final TextEditingController? controller;

  /// The label text for the input decoration.
  final String? labelText;

  /// The hint text for the input decoration.
  final String? hintText;

  /// The minimum length required for the password. Default is 8.
  final int minLength;

  /// Whether to require at least one uppercase letter. Default is true.
  final bool requireUppercase;

  /// Whether to require at least one lowercase letter. Default is true.
  final bool requireLowercase;

  /// Whether to require at least one digit. Default is true.
  final bool requireDigits;

  /// Whether to require at least one special character. Default is true.
  final bool requireSpecialChars;

  /// Whether to prohibit spaces. Default is true.
  final bool prohibitSpaces;

  /// Whether to prohibit dashes. Default is false.
  final bool prohibitDashes;

  /// Whether to prohibit letters. Default is false.
  final bool prohibitLetters;

  /// Whether to prohibit digits. Default is false.
  final bool prohibitDigits;

  /// Whether to prohibit special characters. Default is false.
  final bool prohibitSpecialChars;

  /// Additional custom validator.
  final String? Function(String?)? validator;

  /// Callback when the value changes.
  final void Function(String)? onChanged;

  /// The decoration to use for the text field.
  ///
  /// If provided, [labelText] and [hintText] will be ignored in favor of the decoration's properties.
  /// The suffix icon will be automatically added/overridden to support the visibility toggle.
  final InputDecoration? decoration;

  /// Creates an [EzPasswordField].
  const EzPasswordField({
    super.key,
    this.controller,
    this.labelText = 'Password',
    this.hintText,
    this.minLength = 8,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireDigits = true,
    this.requireSpecialChars = true,
    this.prohibitSpaces = true,
    this.prohibitDashes = false,
    this.prohibitLetters = false,
    this.prohibitDigits = false,
    this.prohibitSpecialChars = false,
    this.validator,
    this.onChanged,
    this.decoration,
  });

  @override
  State<EzPasswordField> createState() => _EzPasswordFieldState();
}

class _EzPasswordFieldState extends State<EzPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    final List<String> missingRequirements = [];

    // Check prohibited characters
    if (widget.prohibitSpaces && value.contains(' ')) {
      missingRequirements.add('no spaces');
    }

    if (widget.prohibitDashes && value.contains('-')) {
      missingRequirements.add('no dashes');
    }

    if (widget.prohibitLetters && value.contains(RegExp(r'[a-zA-Z]'))) {
      missingRequirements.add('no letters');
    }

    if (widget.prohibitDigits && value.contains(RegExp(r'[0-9]'))) {
      missingRequirements.add('no digits');
    }

    if (widget.prohibitSpecialChars &&
        value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      missingRequirements.add('no special characters');
    }

    if (value.length < widget.minLength) {
      missingRequirements.add('at least ${widget.minLength} characters');
    }

    if (widget.requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      missingRequirements.add('an uppercase letter');
    }

    if (widget.requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      missingRequirements.add('a lowercase letter');
    }

    if (widget.requireDigits && !value.contains(RegExp(r'[0-9]'))) {
      missingRequirements.add('a digit');
    }

    if (widget.requireSpecialChars &&
        !value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      missingRequirements.add('a special character');
    }

    if (missingRequirements.isNotEmpty) {
      return 'Issues: ${missingRequirements.join(", ")}';
    }

    if (widget.validator != null) {
      return widget.validator!(value);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration()).copyWith(
      labelText: widget.decoration?.labelText ?? widget.labelText,
      hintText: widget.decoration?.hintText ?? widget.hintText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: _toggleVisibility,
      ),
    );

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: _validate,
      onChanged: widget.onChanged,
      decoration: effectiveDecoration,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
