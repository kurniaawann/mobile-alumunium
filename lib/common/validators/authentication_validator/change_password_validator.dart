class ChangePasswordValidator {
  static String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan password ';
    } else if (value.length < 8) {
      return 'Password harus memiliki setidaknya 8 karakter';
    } else if (!RegExp(r'(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.])')
        .hasMatch(value)) {
      return 'Terdapat huruf besar, angka dan simbol';
    }
    return null;
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan password ';
    } else if (value.length < 8) {
      return 'Password harus memiliki setidaknya 8 karakter';
    } else if (!RegExp(r'(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.])')
        .hasMatch(value)) {
      return 'Terdapat huruf besar, angka dan simbol';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan konfirmasi password ';
    } else if (value != password) {
      return 'Konfirmasi password tidak sesuai';
    }
    return null;
  }
}
