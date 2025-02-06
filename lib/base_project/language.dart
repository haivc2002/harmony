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
  String titleExplorer;
  String drawerDarkMode;
  String contentOutApp;
  String contentItemMonopoly;
  String contentNewsSeeMatches;
  String contentNewStatus;
  String titleLogout;
  String message;
  String contentLogOut;
  String ok;
  String no;
  String setting;
  String language;
  String changeLanguage;
  String isHttp;
  String isDueServer;
  String isNotConnect;
  String isTimeOut;

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
    required this.drawerDarkMode,
    required this.titleExplorer,
    required this.contentOutApp,
    required this.contentItemMonopoly,
    required this.contentNewsSeeMatches,
    required this.contentNewStatus,
    required this.titleLogout,
    required this.message,
    required this.contentLogOut,
    required this.ok,
    required this.no,
    required this.setting,
    required this.language,
    required this.changeLanguage,
    required this.isHttp,
    required this.isDueServer,
    required this.isNotConnect,
    required this.isTimeOut,
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
        drawerDarkMode: map['drawerDarkMode'] ?? '',
        titleExplorer: map['titleExplorer'] ?? '',
        contentOutApp: map['contentOutApp'] ?? '',
        contentItemMonopoly: map['contentItemMonopoly'] ?? '',
        contentNewsSeeMatches: map['contentNewsSeeMatches'] ?? '',
        contentNewStatus: map['contentNewStatus'] ?? '',
        titleLogout: map['titleLogout'] ?? '',
        message: map['message'] ?? '',
        contentLogOut: map['contentLogOut'] ?? '',
        ok: map['ok'] ?? '',
        no: map['no'] ?? '',
        setting: map['setting'] ?? '',
        language: map['language'] ?? '',
        changeLanguage: map['changeLanguage'] ?? '',
        isHttp: map['isHttp'] ?? '',
        isDueServer: map['isDueServer'] ?? '',
        isNotConnect: map['isNotConnect'] ?? '',
        isTimeOut: map['isTimeOut'] ?? '',
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
      'drawerDarkMode': drawerDarkMode,
      'titleExplorer': titleExplorer,
      'contentOutApp': contentOutApp,
      'contentItemMonopoly': contentItemMonopoly,
      'contentNewsSeeMatches': contentNewsSeeMatches,
      'contentNewStatus': contentNewStatus,
      'titleLogout': titleLogout,
      'message': message,
      'contentLogOut': contentLogOut,
      'ok': ok,
      'no': no,
      'setting': setting,
      'language': language,
      'changeLanguage': changeLanguage,
      'isHttp': isHttp,
      'isDueServer': isDueServer,
      'isNotConnect': isNotConnect,
      'isTimeOut': isTimeOut,
    };
  }
}
