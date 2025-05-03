//validator untuk Email Login page
class LoginValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan email ';
    } else if (!RegExp(
            r'^[a-zA-Z0-9._%+-]+(?<!\.)@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$')
        .hasMatch(value)) {
      return 'Email yang anda masukkan tidak valid';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    // Error messages (sesuaikan dengan StringResource Anda)
    const requiredError = 'Harap masukkan password';
    const minLengthError = 'Password minimal 8 karakter';
    const letterError = 'Password harus mengandung huruf';
    const numberError = 'Password harus mengandung angka';
    const specialCharError = 'Password harus mengandung karakter khusus';

    if (value == null || value.isEmpty) {
      return requiredError;
    }

    if (value.length < 8) {
      return minLengthError;
    }

    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return letterError;
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return numberError;
    }

    if (!RegExp(r'[^a-zA-Z0-9]').hasMatch(value)) {
      return specialCharError;
    }

    return null;
  }
}
