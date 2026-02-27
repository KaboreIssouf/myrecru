class EmailValidator {
  // Regex pour un email basique : xxx@yyy.zzz
  static final RegExp _regex =
  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Vérifie si l'email respecte la regex
  static bool isValid(String email) {
    return _regex.hasMatch(email);
  }
}