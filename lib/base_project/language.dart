class Language {
  String hasAccount;
  String notAccount;
  String titleLogin;
  String or;
  String password;
  String emailEmpty;
  String passwordEmpty;
  String titleHome;
  String titleMatch;
  String titleMessage;
  String titleProfile;

  Language({
    required this.hasAccount,
    required this.notAccount,
    required this.titleLogin,
    required this.or,
    required this.password,
    required this.emailEmpty,
    required this.passwordEmpty,
    required this.titleHome,
    required this.titleMatch,
    required this.titleMessage,
    required this.titleProfile,
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
        titleHome: map['titleHome'] ?? '',
        titleMatch: map['titleMatch'] ?? '',
        titleMessage: map['titleMessage'] ?? '',
        titleProfile: map['titleProfile'] ?? '',
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
      'titleHome': titleHome,
      'titleMatch': titleMatch,
      'titleMessage': titleMessage,
      'titleProfile': titleProfile,
    };
  }
}
