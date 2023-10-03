
class UrlContainer{

  static const String domainUrl = 'your_project_url';
  static const String baseUrl = '$domainUrl/api/';


  static const String registrationEndPoint='register';
  static const String loginEndPoint='login';
  static const String userDashboardEndPoint='user/home';
  static const String userLogoutEndPoint='logout';
  static const String forgetPasswordEndPoint='password/email';
  static const String passwordVerifyEndPoint='password/verify-code';
  static const String resetPasswordEndPoint='password/reset';
  static const String referralEndPoint = "my-referrals";
  static const String verify2FAUrl = 'verify-g2fa';



  static const String verifyEmailEndPoint='verify-email';
  static const String verifySmsEndPoint='verify-mobile';
  static const String resendVerifyCodeEndPoint='resend-verify/';

  static const String authorizationCodeEndPoint='authorization';


  static const String dashBoardUrl='dashboard';
  static const String depositHistoryUrl='deposit/history';
  static const String depositMethodUrl='deposit/methods';
  static const String depositInsertUrl='deposit/insert';
  static const String transactionEndpoint='transactions';


  //withdraw
  static const String addWithdrawRequestUrl='withdraw-request';
  static const String withdrawMethodUrl='withdraw-method';
  static const String withdrawRequestConfirm='withdraw-request/confirm';
  static const String withdrawHistoryUrl='withdraw/history';

  static const String planEndPoint = "invest/plans";



  //kyc
  static const String kycFormUrl='kyc-form';
  static const String kycSubmitUrl='kyc-submit';


  static const String generalSettingEndPoint='general-setting';

  //plan
  static const String investUrl = 'invest';
  static const String investStoreUrl = 'invest/store';

  //privacy policy
  static const String privacyPolicyEndPoint='policy';
  static const String faqEndPoint='faq';

  //profile
  static const String getProfileEndPoint='user-info';
  static const String updateProfileEndPoint='profile-setting';
  static const String profileCompleteEndPoint='user-data-submit';


  //change password
  static const String changePasswordEndPoint='change-password';
  static const String countryEndPoint='get-countries';

  static const String deviceTokenEndPoint     = 'save/device/token';
  static const String languageUrl             = 'language/';
  static const String balanceTransfer         = 'balance-transfer';





}