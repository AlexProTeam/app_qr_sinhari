class StatusCodeManager {
  static const int userForceLogoutStatus = 9999;
  static const int loginMultiDevice = 99991;
  static const int unAuthorizedCustom = 1000;
  static const int userPaused = 9998;
  static const int userSuspended = 9997;
  static const int forbidden = 403;
  static const int unAuthorize = 401;
  static const int badRequest = 400;
  static const int scanningPending = 1148;
  static const int scanningComplete = 1163;
  static const int countryNotAllow = 1246;
  static const int notOpenForADV = 1251;
  static const int newJobInTheBanking = 1250;
  static const int graphFacebookUnavailable = 1196;
  static const int scanQAFail = 1269;
  static const int outOfBudget = 1139;
  static const int missingAddress = 1141;
  static const int limitJobs = 1216;
  static const int stillScanning = 1271;

  static const List<int> preventShowToastCodes = [
    notOpenForADV,
    countryNotAllow,
    userSuspended,
    userPaused,
    scanQAFail,
  ];
}

extension StatusCodeExt on int {
  String toErrorMessage(String msg) {
    if (this == StatusCodeManager.loginMultiDevice) {
      return 'yourAccountHasBeenLoggedOtherDevice';
    }

    if (this == StatusCodeManager.userSuspended) {
      return 'notificationAccountSuspendedDescription';
    }

    if (this == StatusCodeManager.graphFacebookUnavailable) {
      return 'accountPausedDescription';
    }

    return msg;
  }
}
