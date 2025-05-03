class RegisterValidator {
  static String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Harap masukan nama lengkap';
    } else if (value.length <= 2) {
      return 'Minimal nama 3 huruf';
    }
    return null;
  }

  static String? validateEmail(String? value, String message) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan email ';
    } else if (!RegExp(
            r'^[a-zA-Z0-9._%+-]+(?<!\.)@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$')
        .hasMatch(value)) {
      return 'Email yang anda masukkan tidak valid';
    } else if (message.toLowerCase().contains('email sudah terdaftar')) {
      return 'Email sudah terdaftar';
    }
    return null;
  }

  static String? validateNoHandphone(String? value, String message) {
    if (value == null || value.isEmpty) {
      return 'Harap masukkan nomor handphone ';
    } else if (!RegExp(r'^08[0-9]{8,11}$').hasMatch(value)) {
      return 'Nomor handphone anda tidak sesuai';
    } else if (message.toLowerCase().contains('no handphone sudah terdaftar')) {
      return 'Nomor handphone sudah terdaftar';
    }

    return null;
  }

  static String? validatePassword(String? value) {
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
