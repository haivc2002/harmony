class Language {
  String hasAccount;
  String notAccount;
  String titleLogin;
  String or;
  String password;
  String emailEmpty;
  String passwordEmpty;
  String titleHome;

  Language({
    required this.hasAccount,
    required this.notAccount,
    required this.titleLogin,
    required this.or,
    required this.password,
    required this.emailEmpty,
    required this.passwordEmpty,
    required this.titleHome
  });

  factory Language.fromMap(Map<String, String> map) {
    return Language(
        hasAccount: map['hasAccount'] ?? '',
        notAccount: map['notAccount'] ?? '',
        titleLogin: map['titleLogin'] ?? '',
        or: map['or'] ?? '',
        password: map['password'] ?? '',
        emailEmpty: map['emailEmpty'] ?? '',
        passwordEmpty: map['passwordEmpty'] ?? '',
        titleHome: map['titleHome'] ?? ''
    );
  }

  Map<String, String> toMap() {
    return {
      'hasAccount': hasAccount,
      'notAccount': notAccount,
      'titleLogin': titleLogin,
      'or': or,
      'password': password,
      'emailEmpty': emailEmpty,
      'passwordEmpty': passwordEmpty,
      'titleHome': titleHome
    };
  }
}
