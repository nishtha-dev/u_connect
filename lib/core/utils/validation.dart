class Validation {
  static bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  static bool isAValidPassword(String password) {
    RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(password);
  }
}
