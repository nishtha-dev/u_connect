enum RouteEnum {
  homePage,
  landingPage,
  loginPage,
  signUpPage,
  forgotPasswordPage
}

extension RouteExt on RouteEnum {
  String get toName => name;

  String get toPath {
    switch (this) {
      case RouteEnum.homePage:
        return '/homePage';
      case RouteEnum.landingPage:
        return '/landingPage';
      case RouteEnum.loginPage:
        return '/loginPage';
      case RouteEnum.signUpPage:
        return '/signUpPage';
      case RouteEnum.forgotPasswordPage:
        return '/forgetPasswordPage';
    }
  }
}
