# EZ Password Field

A **secure, developer-friendly** Flutter password field with built-in visibility toggle and robust validation.

## 🛑 The Problem

Implementing password fields repeatedly involves:
1.  **Boilerplate:** Manually adding `obscureText` toggles and icons.
2.  **Complex Validation:** Writing lengthy regex or logic to check for uppercase, lowercase, digits, etc.
3.  **Inconsistent UX:** Different error messages and validation rules across the app.

## ✅ The EZ Solution

`EzPasswordField` encapsulates best practices for password input into a single, drop-in widget:
-   **Built-in Visibility Toggle:** Comes with an eye icon to show/hide password.
-   **Smart Validation:** Accumulates all missing requirements into a single, clear error message (e.g., "Issues: no spaces, at least 8 characters, a digit").
-   **Robustness:** Easily prohibit specific characters like spaces or dashes (great for PINs).

## ✨ Features

*   **Zero-Config Validation:** Default rules for strong passwords (min length 8, uppercase, lowercase, digits, special chars).
*   **Configurable Rules:** Enable/disable specific requirements or change minimum length.
*   **Robustness Flags:** `prohibitSpaces`, `prohibitDashes`, `prohibitLetters`, etc.
*   **Flexible Styling:** Supports all standard `InputDecoration` properties.

## 📦 Installation

```shell
flutter pub add ez_password_field
```

## 🚀 Usage

Wrap it in a `Form` to enable validation:

```dart
Form(
  key: _formKey,
  child: Column(
    children: [
      EzPasswordField(
        controller: _passwordController,
        decoration: InputDecoration(labelText: 'Password'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
             // Handle valid submission
          }
        },
        child: Text('Submit'),
      )
    ],
  ),
)
```

### PIN Mode (Digits Only)

```dart
EzPasswordField(
  labelText: 'PIN',
  minLength: 4,
  requireUppercase: false,
  requireLowercase: false,
  requireSpecialChars: false,
  requireDigits: true,
  prohibitLetters: true,
  prohibitSpecialChars: true,
  prohibitSpaces: true,
  prohibitDashes: true,
  hintText: 'Enter 4 digits',
)
```

### Custom Validation Logic

You can still add custom logic on top of the built-in validation:

```dart
EzPasswordField(
  validator: (value) {
    if (value != null && value.contains('password')) {
      return 'Password cannot contain "password"';
    }
    return null;
  },
)
```

## 🤝 Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request on [GitHub](https://github.com/Evgenii-Zinner/ez-password-field).

## 📜 License

MIT License - see the [LICENSE](LICENSE) file for details.
