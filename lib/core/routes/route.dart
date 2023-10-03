import 'package:get/get.dart';
import 'package:hyip_lab/view/screens/about/privacy_policy_screen.dart';
import 'package:hyip_lab/view/screens/account/change-password/change_password_screen.dart';
import 'package:hyip_lab/view/screens/account/profile/edit-profile/edit_profile_screen.dart';
import 'package:hyip_lab/view/screens/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:hyip_lab/view/screens/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:hyip_lab/view/screens/auth/kyc/kyc.dart';
import 'package:hyip_lab/view/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:hyip_lab/view/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:hyip_lab/view/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:hyip_lab/view/screens/auth/login/login_screen.dart';
import 'package:hyip_lab/view/screens/auth/registration/registration_screen.dart';
import 'package:hyip_lab/view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:hyip_lab/view/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/home/home_screen.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/menu/menu_screen.dart';
import 'package:hyip_lab/view/screens/bottom_nav_screens/user_account/user_account_screen.dart';
import 'package:hyip_lab/view/screens/deposit/deposit-history/deposit_history_screen.dart';
import 'package:hyip_lab/view/screens/deposit/deposit_webview/deposit_payment_webview.dart';
import 'package:hyip_lab/view/screens/faq/faq_screen.dart';
import 'package:hyip_lab/view/screens/investment/investment_screen.dart';
import 'package:hyip_lab/view/screens/plan/plan_screen.dart';
import 'package:hyip_lab/view/screens/referral/referral_screen.dart';
import 'package:hyip_lab/view/screens/splash_screen/splash_screen.dart';
import 'package:hyip_lab/view/screens/transaction-history/transaction_history_screen.dart';
import 'package:hyip_lab/view/screens/withdraw/withdraw_log/withdraw_history.dart';
import 'package:hyip_lab/view/screens/withdraw/withdraw_money/confirm_withdraw_screen/confirm_withdraw_screen.dart';


class RouteHelper{

  static const String splashScreen='/splash_screen';
  static const String loginScreen = '/login_screen' ;
  static const String registrationScreen = '/registration_screen' ;
  static const String emailVerificationScreen ='/verify_email_screen' ;
  static const String smsVerificationScreen = '/verify_sms_screen';
  static const String forgetPasswordScreen = '/forget_password_screen' ;
  static const String verifyPassCodeScreen = '/verify_pass_code_screen' ;
  static const String resetPasswordScreen = '/reset_pass_screen' ;
  static const String homeScreen='/home_screen';
  static const String profileCompleteScreen='/profile_complete_screen';
  static const String depositScreen='/deposit_screen';
  static const String investmentScreen='/investment_screen';
  static const String confirmWithdrawRequest='/confirm_withdraw_screen';
  static const String withdrawHistoryScreen='/withdraw_history_screen';
  static const String privacyScreen='/privacy_screen';
  static const String depositWebViewScreen='/deposit_webView';
  static const String changePasswordScreen='/change_password';
  static const String transactionHistoryScreen='/transaction_log';
  static const String kycScreen='/kyc_screen';
  static const String menuScreen='/menu_screen';
  static const String planScreen = '/plan_screen';
  static const String referralScreen = "/referral_screen";
  static const String userAccountScreen = "/user_account_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String faqScreen = "/faq_screen";
  static const String notificationScreen = "/notification_screen";

  static const String paymentMethodScreen = "/payment-method-screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String languageScreen = "/language_screen";

  static List<GetPage> routes = [

    GetPage(name: splashScreen,               page: () =>  const SplashScreen()),
    GetPage(name: loginScreen,                page: () =>  const LoginScreen()),
    GetPage(name: registrationScreen,         page: () =>  const RegistrationScreen()),
    GetPage(name: emailVerificationScreen,    page: () =>  EmailVerificationScreen(needSmsVerification: Get.arguments[0],isProfileCompleteEnabled: Get.arguments[1],needTwoFactor: Get.arguments[2],)),
    GetPage(name: smsVerificationScreen,      page: () =>  const SmsVerificationScreen()),

    //forget password
    GetPage(name: forgetPasswordScreen,       page: () =>  const ForgetPasswordScreen()),
    GetPage(name: verifyPassCodeScreen,       page: () =>  const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen,        page: () =>  const ResetPasswordScreen()),
    GetPage(name: homeScreen,                 page: () =>  const HomeScreen()),
    GetPage(name: depositScreen,              page: () =>  const DepositHistoryScreen()),
    GetPage(name: depositWebViewScreen,       page: () =>  WebViewExample(redirectUrl: Get.arguments)),

    //withdraw
    GetPage(name: confirmWithdrawRequest,     page: () =>  ConfirmWithdrawScreen(model: Get.arguments[0],)),
    GetPage(name: withdrawHistoryScreen,      page: () =>  const WithdrawHistoryScreen()),

    GetPage(name: changePasswordScreen,       page: () =>  const ChangePasswordScreen()),
    GetPage(name: profileCompleteScreen,      page: () =>  const ProfileCompleteScreen()),
    GetPage(name: transactionHistoryScreen,   page: () =>  const TransactionHistoryScreen()),
    GetPage(name: privacyScreen,              page: () =>  const PrivacyScreen()),
    GetPage(name: menuScreen,                 page: () =>  const MenuScreen()),
    GetPage(name: investmentScreen,           page: () =>  const InvestmentScreen()),
    GetPage(name: planScreen,                 page: () =>  const PlanScreen()),
    GetPage(name: referralScreen,             page: () =>  const ReferralScreen()),
    GetPage(name: userAccountScreen,          page: () =>  const UserAccountScreen()),
    GetPage(name: editProfileScreen,          page: () =>  const EditProfileScreen()),
    GetPage(name: faqScreen,                  page: () =>  const FaqScreen()),

    GetPage(name: kycScreen,                  page: () =>  const KycScreen()),

    //GetPage(name: paymentMethodScreen,        page: () =>  const PaymentMethodScreen()),
    GetPage(name: twoFactorScreen,            page: () =>  TwoFactorVerificationScreen(isProfileCompleteEnable: Get.arguments)),
  ];
}