class PasswordValidator {
  // Regex : au moins 8 caractères, 1 majuscule, 1 chiffre
  static final RegExp _regex =
  RegExp(r'^(?=.*[A-Z])(?=.*\d).{8,}$');

  /// Vérifie si le mot de passe respecte la regex
  static bool isValid(String password) {
    return _regex.hasMatch(password);
  }

  /// Vérifie si les deux mots de passe sont identiques et valides
  static bool arePasswordsValid(String pass, String confirm) {
    return pass == confirm && isValid(pass);
  }
}